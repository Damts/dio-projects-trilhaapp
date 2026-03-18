import 'package:flutter/material.dart';
import 'package:trilhaapp/models/tarefa.dart';
import 'package:trilhaapp/repositories/tarefa_repository.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefaRepository = TarefaRepository();
  var _tarefas = <Tarefa>[];
  var descricaoController = TextEditingController();
  var apenasNaoConcluidos = false;

  @override
  void initState() {
    super.initState();
    _loadTarefas();
  }

  void _loadTarefas() async {
    if (apenasNaoConcluidos) {
      _tarefas = await tarefaRepository.listarTarefasNaoConcluidos();
    } else {
      _tarefas = await tarefaRepository.listarTarefas();
    }
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
                      await tarefaRepository.adicionarTarefa(
                        Tarefa(descricaoController.text, false),
                      );
                      Navigator.pop(context);
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
                  Switch(value: apenasNaoConcluidos, onChanged: (bool value) {
                    apenasNaoConcluidos = value;
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
                      await tarefaRepository.deletarTarefa(tarefa.id);
                      _loadTarefas();
                    },
                    key: Key(tarefa.id),
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        value: tarefa.concluido, 
                        onChanged: (bool value) async {
                          await tarefaRepository.alterarTarefa(tarefa.id, value);
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