import 'package:flutter/material.dart';
import 'package:trilhaapp/models/imc_sqlite_model.dart';
import 'package:trilhaapp/repositories/sqlite/imc_sqlite_repository.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class CalculadoraImcSQLitePage extends StatefulWidget {
  const CalculadoraImcSQLitePage({super.key});

  @override
  State<CalculadoraImcSQLitePage> createState() => _CalculadoraImcSQLitePageState();
}

class _CalculadoraImcSQLitePageState extends State<CalculadoraImcSQLitePage> {
  var _medidas = <ImcSQLiteModel>[];
  ImcSQLiteRepository medidaRepository = ImcSQLiteRepository();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  bool isEditing = false;

  AppStorageService storage = AppStorageService();

  @override
  void initState() {
    super.initState();
    _loadMedidas();
  }

  void _loadMedidas() async {
    _medidas = await medidaRepository.listarMedidas();
    alturaController.text = (await (storage.getConfiguracoesAltura())).toString();
    setState(() {});
  }

  String _classificacaoIMC(double imc) {
    var classificacao = imc.toDouble();
    switch (classificacao) {
      case ( < 18.5): 
        return 'Magreza grau 0';
      case (>= 18.5 && <= 24.9):
        return 'Normal grau 0';
      case ( >= 25.0 && <= 29.9):
        return 'Sobrepeso grau 1';
      case ( >= 30.0 && <= 39.9):
        return 'Obesidade grau 2';
      case ( >= 40.0):
        return 'Obesidade Grave grau 3';
      default:
        return 'Não foi possivel medir';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(Icons.add),
        onPressed: () => imcDialog(),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                'Calculadora de IMC',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _medidas.length,
                itemBuilder: (BuildContext context, int index) {
                  var medida = _medidas[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dissmissDirection) async {
                      await medidaRepository.deletarMedida(medida.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Calculo de IMC Deletado'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      _loadMedidas();
                    },
                    key: Key(medida.id.toString()),
                    child: ListTile(
                      title: Text('Imc Calculado'),
                      subtitle: Column(
                        children: [
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Peso: ${medida.peso}'
                              ),
                              Text(
                                'Altura ${medida.altura}'
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'IMC: ${medida.imc!.roundToDouble()}'
                              ),
                              Text(_classificacaoIMC(medida.imc!).toString())
                            ],
                          ),
                        ],
                      ),  
                      trailing: IconButton(
                        onPressed: () => imcDialog(medida: medida, isEditing: true),
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> imcDialog({ImcSQLiteModel? medida, bool isEditing = false}) {
    print('ALTURA: ${alturaController.text}');
    if (isEditing) {
      pesoController.text = medida!.peso;
      // alturaController.text = medida.altura;
    } else {
      pesoController.text = '';
      // alturaController.text = '';
    }
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: isEditing ? Text('Editar Medidas') : Text('Adicionar Medidas'),
          content: Wrap(
            // spacing: 20.0,
            runSpacing: 10.0,
            children: [
              Text('Digite seu peso'),
              TextField(
                controller: pesoController,
              ),
              // Trazendo altura de configurações
              // SizedBox(height: 50),
              // Text('Digite sua Altura'),
              // TextField(
              //   controller: alturaController,
              // ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text("Cancelar"),
            ),
            TextButton(onPressed: () async {
              isEditing 
                ? await medidaRepository.alterarMedida(
                    medida!,
                  ) 
                : await medidaRepository.addMedida(
                    ImcSQLiteModel(0, alturaController.text, pesoController.text, 0.0)
                  );              
              Navigator.pop(context);
              setState(() {});
              _loadMedidas();
            }, child: Text("Salvar"))
          ],
        );
      }
    );
  }
}