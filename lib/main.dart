import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:trilhaapp/models/dados_cadastrais_model.dart';
import 'package:trilhaapp/models/tarefa_hive_model.dart';
import 'package:trilhaapp/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  // Carrega o dotenv
  await dotenv.load();
  
  // Para o HIVE 
  WidgetsFlutterBinding.ensureInitialized();
  
  // Chama o path provider
  var documentsDirectory = await path_provider.getApplicationDocumentsDirectory();

  // Chama o Hive
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());

  // Run normal do flutter
  runApp(const MyApp());
}