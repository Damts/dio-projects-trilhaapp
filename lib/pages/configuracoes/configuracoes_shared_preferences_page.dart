import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class ConfiguracoesSharedPreferencesPage extends StatefulWidget {
  const ConfiguracoesSharedPreferencesPage({super.key});

  @override
  State<ConfiguracoesSharedPreferencesPage> createState() => _ConfiguracoesSharedPreferencesPageState();
}

class _ConfiguracoesSharedPreferencesPageState extends State<ConfiguracoesSharedPreferencesPage> {

  // Controllers de texto
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  // Variaveis
  bool temaEscuro = false;
  bool receberNotificacoes = false;

  // Variavel de armazenamento de dados
  AppStorageService storage = AppStorageService();

  @override
  void initState() {
    super.initState();
    _carregarDadosUsuario();
  }

  void _carregarDadosUsuario() async {
    nomeUsuarioController.text = await storage.getConfiguracoesNomeUsuario();
    alturaController.text = (await (storage.getConfiguracoesAltura())).toString();
    temaEscuro = await storage.getConfiguracoesTemaEscuro();
    receberNotificacoes = await storage.getConfiguracoesReceberNotificacao();
    setState(() { });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Configurações'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: ListView(
            children: [
              SwitchListTile(
                title: Text('Receber Notificações'),
                value: receberNotificacoes, 
                onChanged: (bool value) {
                  setState(() {
                    receberNotificacoes = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Tema escuro'),
                value: temaEscuro, 
                onChanged: (bool value) {
                  setState(() {
                    temaEscuro = value;
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
                      await storage.setConfiguracoesAltura(double.parse(alturaController.text));
                    } catch (e) {
                      showDialog(
                        context: context, 
                        builder: (_) {
                          return AlertDialog(
                            title: Text("Meu App"),
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
                    await storage.setConfiguracesNomeUsuario(nomeUsuarioController.text);
                    await storage.setConfiguracoesTemaEscuro(temaEscuro);
                    await storage.setConfiguracoesReceberNotificacao(receberNotificacoes);
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
      ),
    );
  }
}