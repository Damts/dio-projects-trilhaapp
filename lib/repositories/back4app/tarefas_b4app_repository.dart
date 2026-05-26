import 'package:trilhaapp/models/tarefas_b4app_model.dart';
import 'package:trilhaapp/repositories/back4app/back4app_custom_dio.dart';

class TarefasB4appRepository {
  final _customDio = Back4appCustomDio();

  TarefasB4appRepository();
  
  Future<TarefasBack4AppModel> obterTarefas(bool naoConcluidas) async {
    var url = "/tarefas";
    if (naoConcluidas){
      url = "$url?where={\"concluido\":false}";
    }
    var result = await _customDio.dio.get(url);
    return TarefasBack4AppModel.fromJson(result.data);
  }

  Future<void> criarTarefa(TarefaBack4AppModel tarefa) async {
    try {
      await _customDio.dio.post("/tarefas", data: tarefa.toJsonEndpoint()); 
    } catch (e) {
      rethrow;
    }   
  }

  Future<void> atualizarTarefa(TarefaBack4AppModel tarefa) async {
    try {
      await _customDio.dio.put("/tarefas/${tarefa.objectId}", data: tarefa.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }   
  }

  Future<void> removerTarefa(String objectId) async {
    try {
      await _customDio.dio.delete("/tarefas/$objectId");
    } catch (e) {
      rethrow;
    }   
  }
}