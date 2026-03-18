class ImcSQLiteModel {
  int _id = 0;
  String _peso = "";
  String _altura = "";
  double? _imc;

  ImcSQLiteModel(this._id, this._altura, this._peso, this._imc);

  int get id => _id;

  String get peso => _peso;

  String get altura => _altura;

  double? get imc => _imc;

  set id(int id) {
    _id = id;
  }

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