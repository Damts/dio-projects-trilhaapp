import 'dart:math';
import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class NumerosAleatoriosSharedPreferencePage extends StatefulWidget {
  const NumerosAleatoriosSharedPreferencePage({super.key});

  @override
  State<NumerosAleatoriosSharedPreferencePage> createState() => _NumerosAleatoriosSharedPreferencePageState();
}

class _NumerosAleatoriosSharedPreferencePageState extends State<NumerosAleatoriosSharedPreferencePage> {
  int numeroGerado = 0;
  int quantidadeClicks = 0;

  AppStorageService storage = AppStorageService();

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    numeroGerado = await storage.getNumeroAleatorio();
    quantidadeClicks = await storage.getQuantidadeCliques();
    setState(() { });
  }

  /*
  *
  * USANDO SHARED PREFERENCES PARA SALVAR DADOS
  *
  */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Gerador de Números Aleatórios',
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
            await storage.setNumeroAleatorio(numeroGerado);
            await storage.setQuantidadeCliques(quantidadeClicks);
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