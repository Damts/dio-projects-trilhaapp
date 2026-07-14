import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trilhaapp/models/dados_cadastrais_model.dart';
import 'package:trilhaapp/models/tarefa_hive_model.dart';
import 'package:trilhaapp/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:trilhaapp/repositories/tarefa_provider_repository.dart';
import 'package:trilhaapp/services/contador_service.dart';
import 'package:trilhaapp/services/dark_mode_service.dart';

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
    MultiProvider(
      providers: [
          ChangeNotifierProvider<DarkModeService>(create: (_) => DarkModeService()),
          ChangeNotifierProvider<ContadorService>(create: (_) => ContadorService()),
          ChangeNotifierProvider<TarefaProviderRepository>(create: (_) => TarefaProviderRepository()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('pt', 'BR')],
        path: 'lib/assets/translations',
        fallbackLocale: Locale('pt', 'BR'),
        child: const MyApp(),
      ),
    ),
  );
}