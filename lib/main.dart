import 'package:easy_localization/easy_localization.dart';
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

  WidgetsFlutterBinding.ensureInitialized();

  // Para o EasyLocalization
  await EasyLocalization.ensureInitialized();
  
  // Chama o path provider
  var documentsDirectory = await path_provider.getApplicationDocumentsDirectory();

  // Chama o Hive
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());

  // Run normal do flutter
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('pt', 'BR')],
      path: 'lib/assets/translations',
      fallbackLocale: Locale('pt', 'BR'),
      child: const MyApp(),
    ),
  );
}