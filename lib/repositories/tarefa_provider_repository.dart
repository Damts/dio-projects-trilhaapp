import 'package:flutter/cupertino.dart';
import 'package:trilhaapp/models/tarefa.dart';

class TarefaProviderRepository extends ChangeNotifier {
  
  final _tarefas = <Tarefa>[];
  var _apenasNaoConcluidos = false;

  set apenasNaoConcluidos(bool value) {
    _apenasNaoConcluidos = value;
    notifyListeners();
  }

  bool get apenasNaoConcluidos => _apenasNaoConcluidos;

  List<Tarefa> get tarefas => _apenasNaoConcluidos ? _tarefas.where((t) => !t.concluido).toList() : _tarefas;

  void adicionar(Tarefa tarefa) {
    _tarefas.add(tarefa);
    notifyListeners();
  }

  void alterar(Tarefa tarefa) {
    _tarefas.where((t) => t.id == tarefa.id).first.concluido = tarefa.concluido;
    notifyListeners();
  }

  void deletar(String id) {
    _tarefas.remove(_tarefas.where((t) => t.id == id).first);
    notifyListeners();
  }
}