import 'package:trilhaapp/models/imc_sqlite_model.dart';
import 'package:trilhaapp/repositories/sqlite/sqlitedatabase.dart';

class ImcSQLiteRepository {
  Future<List<ImcSQLiteModel>> listarMedidas() async {
    List<ImcSQLiteModel> medidas = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result = await db.rawQuery('SELECT id, peso, altura, imc FROM imc');
    for (var element in result) {
      medidas.add(ImcSQLiteModel(
        int.parse(element['id'].toString()), 
        element['altura'].toString(), 
        element['peso'].toString(), 
        double.parse(element['imc'].toString()),
      ));
    }
    return medidas;
  }

  Future<void> addMedida(ImcSQLiteModel medidas) async {
    print('ALTURA: ${medidas}');
    var doublePeso = double.tryParse(medidas.peso);
    var doubleAltura = double.tryParse(medidas.altura);
    var db = await SQLiteDataBase().obterDataBase();
    
    if (doubleAltura != null && doublePeso != null) {
      medidas.imc = doublePeso / (doubleAltura * doubleAltura);
      await db.rawInsert('INSERT INTO imc (peso, altura, imc) values (?,?,?)',
        [medidas.peso, medidas.altura, medidas.imc]);
    }
  }

  Future<void> alterarMedida(ImcSQLiteModel medidas) async {
    var db = await SQLiteDataBase().obterDataBase();
    var doublePeso = double.tryParse(medidas.peso);
    var doubleAltura = double.tryParse(medidas.altura);
    medidas.imc = (doublePeso! / (doubleAltura! * doubleAltura));
    await db.rawInsert('UPDATE imc SET peso = ?, altura = ?, imc = ? WHERE id = ?',
      [
        medidas.peso,
        medidas.altura,
        medidas.imc,
        medidas.id, 
      ]);
  }

  Future<void> deletarMedida(int id) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert('DELETE FROM imc WHERE id = ?', [id]);
  }
}
