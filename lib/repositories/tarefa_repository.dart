import 'package:trilhaapp/models/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];

  Future<void> adicionarTarefa(Tarefa tarefa) async {
    await Future.delayed(Duration(milliseconds: 50));
    _tarefas.add(tarefa);
  }

  Future<void> alterarTarefa(String id, bool concluido) async {
    await Future.delayed(Duration(milliseconds: 50));
    _tarefas.where((tarefa) => tarefa.id == id).first.concluido = concluido;
  }

  Future<void> deletarTarefa(String id) async {
    await Future.delayed(Duration(milliseconds: 50));
    _tarefas.remove(_tarefas.where((tarefa) => tarefa.id == id).first);
  }

  Future<List<Tarefa>> listarTarefas() async {
    await Future.delayed(Duration(milliseconds: 50));
    return _tarefas;
  }

  Future<List<Tarefa>> listarTarefasNaoConcluidos() async {
    await Future.delayed(Duration(milliseconds: 50));
    return _tarefas.where((tarefa) => !tarefa.concluido).toList();
  }
}