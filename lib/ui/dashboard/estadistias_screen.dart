import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EstadistiasScreen extends StatefulWidget {
  const EstadistiasScreen({Key? key}) : super(key: key);

  @override
  _EstadistiasScreenState createState() => _EstadistiasScreenState();
}

class _EstadistiasScreenState extends State<EstadistiasScreen> {
  List<_PieData> pieData = [
    _PieData("xData", 1, text: "aa"),
    _PieData("xData", 2, text: "aaa"),
    _PieData("xData", 3, text: "aaa"),
    _PieData("xData", 4, text: "aaaa"),
    _PieData("xData", 5, text: "aaaaa"),
    _PieData("xData", 6, text: "aaaaaa"),
    _PieData("xData", 7, text: "aaaaaa"),
    _PieData("xData", 8, text: "aaaaaaa"),
  ];

  @override
  void initState() {
    super.initState();
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
          "Menu Evaluación",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //Initialize the chart widget

          Center(
            child: SfCircularChart(
              title: ChartTitle(text: 'Sales by sales person'),
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
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, {required this.text});
  final String xData;
  final num yData;
  final String text;
}
