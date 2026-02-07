import 'package:trilhaapp/models/imc_model.dart';

class ImcRepository {
  final List<ImcModel> _medidas = [];

  Future<void> addMedida(ImcModel medidas) async {
    var doublePeso = double.tryParse(medidas.peso);
    var doubleAltura = double.tryParse(medidas.altura);
    if (doubleAltura != null && doublePeso != null) {
      medidas.imc = doublePeso / (doubleAltura * doubleAltura);
      await Future.delayed(Duration(milliseconds: 50));
      _medidas.add(medidas);
    }
  }

  Future<void> alterarMedida(String id, String peso, String altura) async {
    await Future.delayed(Duration(microseconds: 50));
    var doublePeso = double.tryParse(peso);
    var doubleAltura = double.tryParse(altura);
    _medidas.where((medida) => medida.id == id).first.altura = doubleAltura!.toString();
    _medidas.where((medida) => medida.id == id).first.peso = doublePeso!.toString();
    _medidas.where((medida) => medida.id == id).first.imc = (doublePeso / (doubleAltura * doubleAltura));
  }

  Future<void> deletarMedida(String id) async {
    await Future.delayed(Duration(microseconds: 50));
    _medidas.remove(_medidas.where((medida) => medida.id == id).first);
  }

  Future<List<ImcModel>> listarMedidas() async {
    return _medidas;
  }
}
