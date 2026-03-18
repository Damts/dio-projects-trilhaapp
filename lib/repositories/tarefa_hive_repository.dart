import 'package:hive/hive.dart';
import 'package:trilhaapp/models/tarefa_hive_model.dart';

class TarefaHiveRepository {
  static late Box _box;
  final String chaveDadosCadastrais = "tarefaHiveModel";

  static Future<TarefaHiveRepository> carregar() async{
    if (Hive.isBoxOpen('tarefaHiveModel')){
      _box = Hive.box('tarefaHiveModel');
    } else {
      _box = await Hive.openBox('tarefaHiveModel');
    }
    
    return TarefaHiveRepository._criar();
  }

  TarefaHiveRepository._criar();

  salvar(TarefaHiveModel tarefaHiveModel) {
    _box.add(tarefaHiveModel);
  }

  List<TarefaHiveModel> obterDados(bool naoConcluido) {
    if (naoConcluido) {
      return _box.values.cast<TarefaHiveModel>().where((e) => !e.concluido).toList();
    }
    return _box.values.cast<TarefaHiveModel>().toList();
  }

  alterarTarefa(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.save();
  }

  deletarTarefa(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.delete();
  }
}