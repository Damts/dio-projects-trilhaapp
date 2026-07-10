import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trilhaapp/models/configuracoes_model.dart';
import 'package:trilhaapp/repositories/configuracoes_repository.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({super.key});

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {

  // Controllers de texto
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  // Variavel de armazenamento de dados
  late ConfiguracoesRepository configuracoesRepository;
  ConfiguracoesModel configuracoesModel = ConfiguracoesModel.vazio();

  @override
  void initState() {
    super.initState();
    _carregarDadosUsuario();
  }

  void _carregarDadosUsuario() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();
    nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    alturaController.text = configuracoesModel.altura.toString();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Configurações Hive'),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          children: [
            SwitchListTile(
              title: Text('Receber Notificações'),
              value: configuracoesModel.receberNotificacoes, 
              onChanged: (bool value) {
                setState(() {
                  configuracoesModel.receberNotificacoes = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Tema escuro'),
              value: configuracoesModel.temaEscuro, 
              onChanged: (bool value) {
                setState(() {
                  configuracoesModel.temaEscuro = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: nomeUsuarioController,
                decoration: InputDecoration(
                  hintText: 'Nome do Usuario',
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: alturaController,
                decoration: InputDecoration(
                  hintText: 'Altura',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                onPressed: () async {
                  // Caso tenha teclado aberto o comando abaixo evita dar erro
                  FocusManager.instance.primaryFocus?.unfocus();
                  try {
                    configuracoesModel.altura = double.parse(alturaController.text);
                  } catch (e) {
                    showDialog(
                      context: context, 
                      builder: (_) {
                        return AlertDialog(
                          title: Text("APP_TITLE".tr()),
                          content: Text("Favor informar uma altura valida"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, 
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      }
                    );
                    return;
                  }
                  configuracoesModel.nomeUsuario = nomeUsuarioController.text;
                  configuracoesRepository.salvar(configuracoesModel);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Dados salvos com sucesso."),
                      backgroundColor: Colors.green,
                    )
                  );
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.amber,
                ),
                child: Text('Salvar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}