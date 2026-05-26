import 'package:flutter/material.dart';
import 'package:trilhaapp/models/viacep_model.dart';
import 'package:trilhaapp/repositories/viacep_repository.dart';

class ConsultaCep extends StatefulWidget {
  const ConsultaCep({super.key});

  @override
  State<ConsultaCep> createState() => _ConsultaCepState();
}

class _ConsultaCepState extends State<ConsultaCep> {
  TextEditingController cepController = TextEditingController(text: "");

  var viacepModel = ViaCEPModel();
  var viacepRepository = ViacepRepository();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async { },
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Text(
                "Consulta de CEP",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: cepController,
                keyboardType: TextInputType.number,
                // maxLength: 8,
                onChanged: (value) async {
                  var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                  debugPrint(cep);
                  if (cep.length == 8) {
                    setState(() {
                      _isLoading = true;
                    });
                    viacepModel = await viacepRepository.consultarCep(cep);
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
              const SizedBox(height: 24),
              // Widget para setar visibilidade de coisas
              Visibility(
                visible: _isLoading,
                child: CircularProgressIndicator(),
              ),
              // Ou fazer com IF
              if (_isLoading) CircularProgressIndicator(),
              Text(
                viacepModel.logradouro ?? "",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${viacepModel.localidade ?? ""} - ${viacepModel.uf ?? ""}",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        ),
      );
  }
}