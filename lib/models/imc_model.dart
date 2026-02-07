import 'package:flutter/material.dart';

class ImcModel {
  final String _id = UniqueKey().toString();
  String _peso;
  String _altura;
  double _imc = 0.0;

  ImcModel(this._altura, this._peso);

  String get id => _id;

  String get peso => _peso;

  String get altura => _altura;

  double get imc => _imc;

  set peso(String peso) {
    _peso = peso;
  }

  set altura(String altura) {
    _altura = altura;
  }

  set imc(double imc) {
    _imc = imc;
  }
}