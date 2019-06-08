import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const String moedasUrlReques =
    "https://api.hgbrasil.com/finance?format=json&key=9e645fa0";

class ResponseRequest {
  Future<Map> getMoedas(String url) async {
    http.Response response = await (http.get(url));
    return json.decode(response.body);
  }
}
