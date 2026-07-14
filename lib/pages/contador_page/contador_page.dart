import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trilhaapp/services/contador_service.dart';

class ContadorPage extends StatelessWidget {
  const ContadorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<ContadorService>(
          builder: (context, contadorService, child) {
            return Text(
              contadorService.contador.toString(),
              style: TextStyle(
                fontSize: 24,
              ),
            );
          }
        ),
        TextButton(
          onPressed: () {
            Provider.of<ContadorService>(context, listen: false).incrementar();
          }, 
          child: Text(
            "Incrementar",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}