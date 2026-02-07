import 'package:flutter/material.dart';
import 'package:trilhaapp/models/imc_model.dart';
import 'package:trilhaapp/repositories/imc_repository.dart';

class CalculadoraImc extends StatefulWidget {
  const CalculadoraImc({super.key});

  @override
  State<CalculadoraImc> createState() => _CalculadoraImcState();
}

class _CalculadoraImcState extends State<CalculadoraImc> {
  var _medidas = <ImcModel>[];
  var medidaRepository = ImcRepository();
  TextEditingController pesoController = TextEditingController();
  var alturaController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadMedidas();
  }

  void _loadMedidas() async {
    _medidas = await medidaRepository.listarMedidas();
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
                    key: Key(medida.id),
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
                                'IMC: ${medida.imc.roundToDouble()}'
                              ),
                              Text(_classificacaoIMC(medida.imc).toString())
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

  Future<dynamic> imcDialog({ImcModel? medida, bool isEditing = false}) {
    if (isEditing) {
      pesoController.text = medida!.peso;
      alturaController.text = medida.altura;
    } else {
      pesoController.text = '';
      alturaController.text = '';
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
              // SizedBox(height: 50),
              Text('Digite sua Altura'),
              TextField(
                controller: alturaController,
              ),
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
                    medida!.id, 
                    pesoController.text, 
                    alturaController.text
                  ) 
                : await medidaRepository.addMedida(
                    ImcModel(alturaController.text, pesoController.text)
                  );
              Navigator.pop(context);
              setState(() {});
            }, child: Text("Salvar"))
          ],
        );
      }
    );
  }
}