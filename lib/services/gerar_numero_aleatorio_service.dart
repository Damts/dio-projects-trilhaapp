import 'dart:math';

class GerarNumeroAleatorioService {
  static int gerarNumeroAleatorio(int numeroMaximo) {
    Random numeroAleatorio = Random();
    return numeroAleatorio.nextInt(numeroMaximo);
  }
}