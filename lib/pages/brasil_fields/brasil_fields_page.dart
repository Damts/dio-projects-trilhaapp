import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BrasilFieldsPage extends StatefulWidget {
  const BrasilFieldsPage({super.key});

  @override
  State<BrasilFieldsPage> createState() => _BrasilFieldsPageState();
}

class _BrasilFieldsPageState extends State<BrasilFieldsPage> {
  final _cepController = TextEditingController();
  final _cpfController = TextEditingController();
  final _moedaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Usando Brasil Fields
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Usando Cep Input Formatter
              Text("CEP"),
              TextFormField(
                controller: _cepController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
              ),
              const SizedBox(height: 24),
              // Usando CPF Input Formatter
              Text("CPF"),
              TextFormField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),
              const SizedBox(height: 24),
              // Usando Moeda Input Formatter
              Text("Moeda"),
              TextFormField(
                controller: _moedaController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CentavosInputFormatter(moeda: true),
                ],
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 32),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Usando CPF Validator para validar CPF
                    print(CPFValidator.isValid(_cpfController.text));
                    // Usando CPF Validator para gera CPF Valido
                    print(CPFValidator.isValid(CPFValidator.generate()));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Continuar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}