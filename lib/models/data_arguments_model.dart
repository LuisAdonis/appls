import 'package:appls/models/libro_model.dart';

class DataArguments {
  final String? nombreac;
  final String? ctg;
  final String nodep;

  DataArguments({this.nombreac, this.ctg, required this.nodep});
}

class DataArguments1 {
  final String? nombreac;
  final String? ctg;
  final LibroModel nodep;

  DataArguments1({this.nombreac, this.ctg, required this.nodep});
}
