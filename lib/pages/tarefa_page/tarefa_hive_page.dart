import 'package:flutter/material.dart';
import 'package:trilhaapp/models/tarefa_hive_model.dart';
import 'package:trilhaapp/repositories/tarefa_hive_repository.dart';

class TarefaHivePage extends StatefulWidget {
  const TarefaHivePage({super.key});

  @override
  State<TarefaHivePage> createState() => _TarefaHivePageState();
}

class _TarefaHivePageState extends State<TarefaHivePage> {
  late TarefaHiveRepository tarefaHiveRepository;
  var _tarefas = <TarefaHiveModel>[];
  var descricaoController = TextEditingController();
  var naoConcluidos = false;

  @override
  void initState() {
    super.initState();
    _loadTarefas();
  }

  void _loadTarefas() async {
    tarefaHiveRepository = await TarefaHiveRepository.carregar();
      _tarefas = tarefaHiveRepository.obterDados(naoConcluidos);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        onPressed: () {
          descricaoController.text = "";
          showDialog(
            context: context, 
            builder: (BuildContext bc) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text("Adicionar Tarefa"),
                content: TextField(
                  controller: descricaoController,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    child: Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await tarefaHiveRepository.salvar(
                        TarefaHiveModel.criar(descricaoController.text, false),
                      );
                      Navigator.pop(context);
                      _loadTarefas();
                      setState(() {});
                    }, 
                    child: Text("Salvar"),
                  ) 
                ],
              );
            }
          );
        }, 
        child: Icon(Icons.add),
      ),
      // ListView Builder para lista de tarefas
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Apenas não concluidas",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Switch(value: naoConcluidos, onChanged: (bool value) {
                    naoConcluidos = value;
                    _loadTarefas();
                  })
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext bc, int index) {
                  var tarefa = _tarefas[index];
                  // Permite movendo lateral nos itens util para usar em delete de itens
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {
                      await tarefaHiveRepository.deletarTarefa(tarefa);
                      _loadTarefas();
                    },
                    key: Key(tarefa.descricao),
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        value: tarefa.concluido, 
                        onChanged: (bool value) async {
                          tarefa.concluido = value;
                          await tarefaHiveRepository.alterarTarefa(tarefa);
                          _loadTarefas();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}