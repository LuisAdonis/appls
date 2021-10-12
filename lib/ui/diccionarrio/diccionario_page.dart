import 'package:appls/models/data_arguments_model.dart';
import 'package:appls/models/diccionario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class DiccionarioPage extends StatefulWidget {
  const DiccionarioPage({Key? key}) : super(key: key);

  @override
  _DiccionarioPageState createState() => _DiccionarioPageState();
}

class _DiccionarioPageState extends State<DiccionarioPage> {
  final TextEditingController _controller = TextEditingController();
  List<DiccionarioModel> busqueda = [];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    makeRequestini();
  }

  Future makeRequest(String i) async {
    Uri url = Uri.parse("http://www.plataformaconadis.gob.ec/~platafor/diccionario/?ajax=on&post_type=st_kb&s=$i");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      busqueda.clear();
      var document = parse(response.body);
      document.getElementsByTagName("a").forEach((element) {
        // print(element.attributes);
        // print(element.text);
        setState(() {
          busqueda.add(DiccionarioModel(text: element.text, href: element.attributes['href']!));
        });
      });
    }
  }

  Future makeRequestini() async {
    Uri url = Uri.parse("http://www.plataformaconadis.gob.ec/~platafor/diccionario/?article_category=frases-comunes");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      busqueda.clear();
      var document = parse(response.body);
      document.getElementsByClassName("entry-title").forEach((e) {
        // print("entry-title");
        e.getElementsByTagName("a").forEach((element) async {
          // ignore: avoid_print
          print("a");
          setState(() {
            busqueda.add(DiccionarioModel(text: element.text, href: element.attributes['href']!));
          });
          // await codificarimagen("${element.attributes['href']}", e.text);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          "Diccionario de Lengua de Señas Ecuatoriana Gabriel Román",
          style: TextStyle(color: Colors.black87),
        ),
        // backgroundColor: HexColor(args.startColor),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: TextField(
                  onChanged: (String value) async {
                    await makeRequest(value);
                  },
                  controller: _controller,
                  decoration: const InputDecoration(hintText: 'Buscar', border: InputBorder.none),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: busqueda.length,
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          'Resultados',
                          arguments: DataArguments(
                            nombreac: busqueda[index].text,
                            ctg: busqueda[index].text,
                            nodep: busqueda[index].href,
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            busqueda[index].text,
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
