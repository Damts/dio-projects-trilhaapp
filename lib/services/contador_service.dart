import 'package:flutter/material.dart';

class ContadorService extends ChangeNotifier {
  int _contador = 0;

  int get contador => _contador;

  void incrementar() {
    _contador++;
    notifyListeners();
  }

  void decrementar() {
    _contador--;
    notifyListeners();
  }

  void zerar() {
    _contador = 0;
    notifyListeners();
  }
}