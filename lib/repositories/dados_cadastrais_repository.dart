import 'package:hive/hive.dart';
import 'package:trilhaapp/models/dados_cadastrais_model.dart';

class DadosCadastraisRepository {
  static late Box _box;
  final String chaveDadosCadastrais = "dadosCadastraisModel";

  static Future<DadosCadastraisRepository> carregar() async{
    if (Hive.isBoxOpen('dadosCadastraisModel')){
      _box = Hive.box('dadosCadastraisModel');
    } else {
      _box = await Hive.openBox('dadosCadastraisModel');
    }
    
    return DadosCadastraisRepository._criar();
  }

  DadosCadastraisRepository._criar();

  void salvar(DadosCadastraisModel dadosCadastraisModel) {
    _box.put('chaveDadosCadastrais', dadosCadastraisModel);
  } 

  DadosCadastraisModel obterDados() {
    var dadosCadastraisModel = _box.get('chaveDadosCadastrais');
    if (dadosCadastraisModel == null) {
      return DadosCadastraisModel.vazio();
    }
    return dadosCadastraisModel;
  }
}