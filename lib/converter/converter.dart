import 'package:flutter/material.dart';

class MoedasConverter {
  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();

  double _dollar;
  double _euro;

  void realChanged(String value) {
    var real = double.parse(value);
    dollarController.text = (real / _dollar).toStringAsFixed(2);
    euroController.text = (real / _euro).toStringAsFixed(2);
  }

  void dollarChanged(String value) {
    var dollar = double.parse(value);
    var dollarToreal = dollar * this._dollar;
    realController.text = (dollarToreal).toStringAsFixed(2);
    euroController.text = (dollarToreal / _euro).toStringAsFixed(2);
  }

  void euroChanged(String value) {
    var euro = double.parse(value);
    var euroToReal = euro * this._euro;
    realController.text = (euroToReal).toStringAsFixed(2);
    dollarController.text = (euroToReal / _dollar).toStringAsFixed(2);
  }

  void apply(Map data) {
    _dollar = data["results"]["currencies"]["USD"]["buy"];
    _euro = data["results"]["currencies"]["EUR"]["buy"];
  }
}
