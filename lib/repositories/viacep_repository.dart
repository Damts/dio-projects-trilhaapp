import 'dart:convert';

import 'package:trilhaapp/models/viacep_model.dart';
import 'package:http/http.dart' as http;

class ViacepRepository {
  Future<ViaCEPModel> consultarCep(String cep) async {
    var response = await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ViaCEPModel.fromJson(json);
    }
    return ViaCEPModel();
  }
}