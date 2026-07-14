import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trilhaapp/models/tarefa.dart';
import 'package:trilhaapp/repositories/tarefa_provider_repository.dart';

class TarefaProviderPage extends StatelessWidget {
  var descricaoController = TextEditingController();

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
                      Provider.of<TarefaProviderRepository>(context, listen: false).adicionar(Tarefa(descricaoController.text, false));
                      Navigator.pop(context);
                    }, 
                    child: Text("Salvar"),
                  ),
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
                  Consumer<TarefaProviderRepository>(
                    builder: (context, tarefaRepository, child) {
                      return Switch(
                        value: tarefaRepository.apenasNaoConcluidos,
                        onChanged: (bool value) {
                          Provider.of<TarefaProviderRepository>(context, listen: false).apenasNaoConcluidos = value;
                        }
                      );
                    }
                  )
                ],
              ),
            ),
            Expanded(
              child: Consumer<TarefaProviderRepository>(
                builder: (context, tarefaRepository, child) {
                  return ListView.builder(
                    itemCount: tarefaRepository.tarefas.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var tarefa = tarefaRepository.tarefas[index];
                      // Permite movendo lateral nos itens util para usar em delete de itens
                      return Dismissible(
                        onDismissed: (DismissDirection dismissDirection) async {
                          Provider.of<TarefaProviderRepository>(context, listen: false).deletar(tarefa.id.toString());
                        },
                        key: Key(tarefa.id),
                        child: ListTile(
                          title: Text(tarefa.descricao),
                          trailing: Switch(
                            value: tarefa.concluido, 
                            onChanged: (bool value) async {
                              tarefa.concluido = value;
                              Provider.of<TarefaProviderRepository>(context, listen: false).alterar(tarefa);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              ),
            ),
          ],
        ),
      )
    );
  }
}