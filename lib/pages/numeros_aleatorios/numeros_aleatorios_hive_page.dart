import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() => _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  int numeroGerado = 0;
  int quantidadeClicks = 0;

  late Box boxNumerosAleatorios;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    if (Hive.isBoxOpen('box_numeros_aleatorios')) {
      boxNumerosAleatorios = Hive.box('box_numeros_aleatorios');
    } else {
      boxNumerosAleatorios = await Hive.openBox('box_numeros_aleatorios');
    }
    numeroGerado = boxNumerosAleatorios.get('numeroGerado') ?? 0;
    quantidadeClicks = boxNumerosAleatorios.get('quantidadeClicks') ?? 0;
    setState(() { });
  }

  /*
  *
  * USANDO HIVE PARA SALVAR DADOS
  *
  */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hive',
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.blue,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            // Zerando o valor salvo
            // await storage.remove(CHAVE_NUMERO_ALEATORIO);
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(1000);
              quantidadeClicks = quantidadeClicks + 1;
            });
            boxNumerosAleatorios.put('numeroGerado', numeroGerado);
            boxNumerosAleatorios.put('quantidadeClicks', quantidadeClicks);
           },
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numeroGerado.toString(),
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                quantidadeClicks.toString(),
                style: TextStyle(
                  fontSize: 26,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}