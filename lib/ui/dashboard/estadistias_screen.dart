import 'package:appls/models/stadismodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EstadistiasScreen extends StatefulWidget {
  const EstadistiasScreen({Key? key}) : super(key: key);

  @override
  _EstadistiasScreenState createState() => _EstadistiasScreenState();
}

class _EstadistiasScreenState extends State<EstadistiasScreen> {
  List<_PieData> pieData = [];
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final _user = FirebaseAuth.instance.currentUser;

  late Query _todoQuery;

  String cat = "";

  // ignore: prefer_typing_uninitialized_variables
  var _selectedItem;
  late List<DropdownMenuItem<_PieData>> _dropdownMenuItems;
  @override
  void initState() {
    _todoQuery = _database.reference().child("EvaluacionRes").child(_user!.uid);
    super.initState();
    _todoQuery.onChildAdded.listen(onEntryAdded);
    _dropdownMenuItems = buildDropDownMenuItems(pieData);
  }

  onEntryAdded(Event event) async {
    setState(() {
      pieData.add(
        _PieData(event.snapshot.key.toString(), 1, text: event.snapshot.key.toString()),
      );
    });
    _dropdownMenuItems = buildDropDownMenuItems(pieData);
  }

  List<_SalesData> data = [];
  List<DropdownMenuItem<_PieData>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<_PieData>> items = [];
    for (_PieData listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: SizedBox(
            width: 250,
            child: Text(listItem.text.toUpperCase(), overflow: TextOverflow.ellipsis),
          ),
          value: listItem,
        ),
      );
    }
    return items;
  }

  void validando(_PieData? value) {
    setState(() {
      _selectedItem = value!;
      data.clear();
    });
    var conut = 1;
    _database.reference().child("EvaluacionRes").child(_user!.uid).child(value!.text).limitToLast(6).onChildAdded.listen((event) {
      setState(() {
        data.add(_SalesData(
          "Intento $conut",
          StadisModel.fromSnapshot(event.snapshot).preguntascorrectas.toDouble(),
        ));
        cat = StadisModel.fromSnapshot(event.snapshot).categoria;
      });
      conut++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          " ",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Grafica de resultados de evaluaciones",
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Segoe UI',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<_PieData>(
                  value: _selectedItem,
                  items: _dropdownMenuItems,
                  hint: const Text("Seleciona una opcion", overflow: TextOverflow.ellipsis),
                  onChanged: validando,
                ),
              ),
            ),
            // DropdownButton(
            //   value: _value,
            //   selectedItemBuilder: (BuildContext context) {
            //     return pieData.map<Widget>((_PieData item) {
            //       return Text(item.text.toUpperCase().replaceAll("_", " ").replaceAll("-", " "));
            //     }).toList();
            //   },
            //   items: pieData.map((_PieData item) {
            //     return DropdownMenuItem<String>(
            //       child: Text(item.text.toUpperCase().replaceAll("_", " ").replaceAll("-", " ")),
            //       value: item.text,
            //     );
            //   }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       _value = value.toString();
            //     });
            //     data.clear();
            //     var conut = 1;
            //     _database.reference().child("EvaluacionRes").child(_user!.uid).child(_value).onChildAdded.listen((event) {
            //       // final s = StadisModel.fromSnapshot(event.snapshot).fecha;
            //       // ignore: avoid_print
            //       // print(DateTime.now());
            //       // final df = DateFormat('dd/MM ');
            //       // ignore: avoid_print
            //       // print(df.format(
            //       //   DateTime.fromMillisecondsSinceEpoch(s * 1000),
            //       // ));
            //       // ignore: avoid_print
            //       // print(StadisModel.fromSnapshot(event.snapshot).categoria);
            //       setState(() {
            //         data.add(_SalesData(
            //           "Intento $conut",
            //           StadisModel.fromSnapshot(event.snapshot).preguntascorrectas.toDouble(),
            //         ));
            //         cat = StadisModel.fromSnapshot(event.snapshot).categoria;
            //       });
            //       conut++;
            //     });
            //   },
            // ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: pieData.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return ListTile(
            //         title: Text(pieData[index].text.toUpperCase()),
            //         onTap: () {
            //           data.clear();
            //           var conut = 1;
            //           _database.reference().child("EvaluacionRes").child(_user!.uid).child(pieData[index].text).onChildAdded.listen((event) {
            //             final s = StadisModel.fromSnapshot(event.snapshot).fecha;
            //             // ignore: avoid_print
            //             print(DateTime.now());
            //             final df = DateFormat('dd/MM ');
            //             // ignore: avoid_print
            //             print(df.format(
            //               DateTime.fromMillisecondsSinceEpoch(s * 1000),
            //             ));
            //             // ignore: avoid_print
            //             print(StadisModel.fromSnapshot(event.snapshot).categoria);
            //             setState(() {
            //               data.add(_SalesData(
            //                 "Intento $conut",
            //                 StadisModel.fromSnapshot(event.snapshot).preguntascorrectas.toDouble(),
            //               ));
            //               cat = StadisModel.fromSnapshot(event.snapshot).categoria;
            //             });
            //             conut++;
            //           });
            //         },
            //       );
            //     },
            //   ),
            // ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              legend: Legend(isVisible: false),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                  dataSource: data,
                  name: cat.toUpperCase().replaceAll("-", " ").replaceAll("_", " "),
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales * 20,
                  yAxisName: "a",
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                )
              ],
            ),

            //Initialize the chart widget

            Center(
              child: SfCircularChart(
                title: ChartTitle(text: 'Categorias'),
                legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                series: <DoughnutSeries<_PieData, String>>[
                  DoughnutSeries<_PieData, String>(
                    dataSource: pieData,
                    onPointTap: (a) {
                      // ignore: avoid_print
                      print(a.dataPoints!.first);
                    },
                    explode: true,
                    xValueMapper: (_PieData data, _) => data.xData,
                    yValueMapper: (_PieData data, _) => data.yData,
                    dataLabelMapper: (_PieData data, _) => data.text,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelIntersectAction: LabelIntersectAction.hide,
                      showZeroValue: false,
                      connectorLineSettings: ConnectorLineSettings(type: ConnectorType.curve),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, {required this.text});
  final String xData;
  final num yData;
  final String text;
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
