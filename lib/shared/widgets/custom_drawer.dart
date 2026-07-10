import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trilhaapp/pages/auto_size_text/auto_size_text_page.dart';
import 'package:trilhaapp/pages/battery/battery_page.dart';
import 'package:trilhaapp/pages/camera/camera_page.dart';
import 'package:trilhaapp/pages/connectivity_plus/connectivity_plus_page.dart';
import 'package:trilhaapp/pages/geolocator/geolocator_page.dart';
import 'package:trilhaapp/pages/percent_indicator/percent_indicator_page.dart';
import 'package:trilhaapp/pages/qr_code/qr_code_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:trilhaapp/pages/characters/characters_page.dart';
// import 'package:trilhaapp/pages/configuracoes/configuracoes_hive_page.dart';
// import 'package:trilhaapp/pages/configuracoes/configuracoes_shared_preferences_page.dart';
// import 'package:trilhaapp/pages/dados_cadastrais/dados_cadastrais_hive.dart';
// import 'package:trilhaapp/pages/login_page.dart';
// import 'package:trilhaapp/pages/dados_cadastrais/dados_cadastrais_shared_preferences.dart';
// import 'package:trilhaapp/pages/numeros_aleatorios/numeros_aleatorios_hive_page.dart';
// import 'package:trilhaapp/pages/numeros_aleatorios/numeros_aleatorios_shared_preference_page.dart';
// import 'package:trilhaapp/pages/posts/dio/posts_dio_page.dart';
// import 'package:trilhaapp/pages/posts/http/posts_http_page.dart';
import 'package:trilhaapp/pages/tarefa_page/tarefa_http_page.dart';
// import 'package:trilhaapp/repositories/back4app/tarefas_b4app_repository.dart';
// import 'package:trilhaapp/repositories/marvel/marvel_repository.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: Border(),
      child: ListView(
        children: [
          // Header de Usuario
          InkWell(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                context: context,
                builder: (BuildContext bc) {
                  return SafeArea(
                    child: Wrap(
                      children: [
                        ListTile(
                          title: Text('Camera'),
                          leading: Icon(Icons.camera),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('Galeria'),
                          leading: Icon(Icons.album),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'lib/assets/images/eren-mikasa.png',
                  fit: BoxFit.fill,
                ),
              ),
              accountName: Text("Mateus Soares"),
              accountEmail: Row(children: [Text("email@email.com")]),
            ),
          ),
          Divider(),
          SizedBox(height: 10),

          // Usando Font Awesome Icons para icones
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.percent,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("PERCENT_INDICATOR".tr()),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PercentIndicatorPage()),
              );
            },
          ),
          const Divider(),
          SizedBox(height: 10),

          // Indicador da bateria
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.batteryFull,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("BATERIA".tr()),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BatteryPage()),
              );
            },
          ),
          const Divider(),
          SizedBox(height: 10),

          // Auto Size Text
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.paperclip,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("Auto Size Text"),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AutoSizeTextPage()),
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Abrindo URL com url launcher
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.globe,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("URL Launcher"),
                ],
              ),
            ),
            onTap: () async {
              final uri = Uri.parse('https://youtube.com');
              await launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
                // Com Launch mode abre fora do app, sem ele abre dentro do app
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Share/compartilhar
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.share,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("SHARE".tr()),
                ],
              ),
            ),
            onTap: () async {
              SharePlus.instance.share(
                ShareParams(
                  text: 'Compartilhando link do youtube: https://youtube.com',
                ),
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 10),

          // intl
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.brazilianRealSign,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("INTL"),
                ],
              ),
            ),
            onTap: () {
              var f = NumberFormat('#,###.0#', 'pt_BR');
              var fBR = NumberFormat('#,###.0#', 'en_US');
              debugPrint(f.format(12345.678));
              debugPrint(fBR.format(12345.678));

              var data = DateTime(2026, 06, 06);
              // print(DateFormat('EEEEE', 'pt_BR').format(data)); //BR esta dando erro
              debugPrint(DateFormat('EEEEE', 'en_US').format(data)); // US esta aparecendo somente 1 letra
              debugPrint(data.toString());
            },
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Eazy Localization
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.flag,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("MUDAR_LINGUAGEM".tr()),
                ],
              ),
            ),
            onTap: () {
              if (context.locale.toString() == "pt_BR") {
                context.setLocale(Locale('en','US'));
              } else {
                context.setLocale(Locale('pt','BR'));
              }
              Navigator.pop(context);
            },
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Path provider
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.folder,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("Path Provider"),
                ],
              ),
            ),
            onTap: () async {
              Directory directory = await path_provider.getTemporaryDirectory();
              debugPrint('Path Provider: ${directory.path}');
              directory = await path_provider.getApplicationSupportDirectory();
              debugPrint('Path Provider: ${directory.path}');
              directory = await path_provider.getApplicationDocumentsDirectory();
              debugPrint('Path Provider: ${directory.path}');
            },
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Package Info
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.appStore,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("Package Info"),
                ],
              ),
            ),
            onTap: () async {
              PackageInfo packageInfo = await PackageInfo.fromPlatform();

              String appName = packageInfo.appName;
              String packageName = packageInfo.packageName;
              String version = packageInfo.version;
              String buildNumber = packageInfo.buildNumber;

              debugPrint(appName);
              debugPrint(packageName);
              debugPrint(version);
              debugPrint(buildNumber);

              debugPrint(Platform.operatingSystem);
              debugPrint(Platform.numberOfProcessors.toString());
              debugPrint(Platform.localeName);
              debugPrint(Platform.localHostname);
              debugPrint(Platform.pathSeparator);
              debugPrint(Platform.script.toString());
              debugPrint(Platform.version);
            },
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Device Package Plus
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.mobile,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("Informações Dispositivo"),
                ],
              ),
            ),
            onTap: () async {
              DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
              if (Platform.isAndroid){
                AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                debugPrint('Running on ${androidInfo.model}');
              } else if (Platform.isIOS) {
                IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                debugPrint('Running on ${iosInfo.utsname.machine}');
              } else {
                WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
                debugPrint('Running on ${webBrowserInfo.userAgent}');
              }
            },
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Connectivity Plus
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.wifi,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("Informações de Conexão"),
                ],
              ),
            ),
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ConnectivityPlusPage()));
            },
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Geolocator
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.locationDot,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("Geolocator"),
                ],
              ),
            ),
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (_) => GeolocatorPage()));
            },
          ),
          const Divider(),
          const SizedBox(height: 10),

          // QR CODE com mobile_scanner
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.qrcode,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("QR CODE"),
                ],
              ),
            ),
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (_) => QrCodePage()));
            },
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Camera com Image picker
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.camera,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text("Camera"),
                ],
              ),
            ),
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CameraPage()));
            },
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Meu Perfil
          // InkWell(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          //     width: double.infinity,
          //     child: Row(
          //       children: [
          //         Icon(Icons.person),
          //         const SizedBox(width: 4),
          //         Text("Meu Perfil"),
          //       ],
          //     )),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const DadosCadastraisHivePage(),
          //       ),
          //     );
          //   },
          // ),
          // SizedBox(height: 10),

          // // Configurações
          // InkWell(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          //     width: double.infinity,
          //     child: Row(
          //       children: [
          //         Icon(Icons.settings),
          //         const SizedBox(width: 4),
          //         Text("Configurações"),
          //       ],
          //     )),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfiguracoesSharedPreferencesPage()));
          //   },
          // ),
          // SizedBox(height: 10),

          // // Termos de Uso
          // InkWell(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          //     width: double.infinity,
          //     child: Row(
          //       children: [
          //         Icon(Icons.rule),
          //         const SizedBox(width: 4),
          //         Text("Termos de uso e Privacidade"),
          //       ],
          //     )),
          //   onTap: () {
          //     showModalBottomSheet(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       context: context,
          //       builder: (BuildContext bc) {
          //         return SafeArea(
          //           child: Container(
          //             padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          //             child: Column(
          //               children: [
          //                 Text(
          //                   "Termos de Privacidade",
          //                   style: TextStyle(
          //                     fontSize: 24,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 const SizedBox(height: 8),
          //                 Text(
          //                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec urna nisi, auctor sed scelerisque eu, consectetur id velit. Suspendisse vulputate odio enim, vitae maximus nisi interdum vitae. Nulla facilisi. Pellentesque malesuada nulla sapien, vitae mattis eros ultrices nec. Sed ac odio lectus. Praesent dignissim eros odio, ut varius elit vehicula pellentesque.",
          //                   style: TextStyle(
          //                     fontSize: 18
          //                   ),
          //                   // Alinhar Texto
          //                   textAlign: TextAlign.justify,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         );
          //       }
          //     );
          //   },
          // ),
          // Divider(),
          // SizedBox(height: 10),

          // // Gerador de numeros aleatorios
          // InkWell(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          //     width: double.infinity,
          //     child: Row(
          //       children: [
          //         Icon(Icons.numbers),
          //         const SizedBox(width: 4),
          //         Text("Gerador de Numeros"),
          //       ],
          //     )),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => const NumerosAleatoriosHivePage()));
          //   },
          // ),
          // SizedBox(height: 10),
          // // Pegando POST via API
          // InkWell(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          //     width: double.infinity,
          //     child: Row(
          //       children: [
          //         Icon(Icons.post_add),
          //         const SizedBox(width: 4),
          //         Text("Posts com API"),
          //       ],
          //     )),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => const PostsDioPage()));
          //   },
          // ),
          // Divider(),
          // SizedBox(height: 10),
          // Pegando Herois via API
          // InkWell(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          //     width: double.infinity,
          //     child: Row(
          //       children: [
          //         Icon(Icons.help),
          //         const SizedBox(width: 4),
          //         Text("Hérois com API"),
          //       ],
          //     )),
          //   onTap: () async {
          //     debugPrint('Aqui deveria ter herois, API não existe mais');
          //     // var marvelRepository = MarvelRepository();
          //     // var heroes = await marvelRepository.getCharacters();
          //     // print('$heroes');
          //     Navigator.pop(context);
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => const CharactersPage()));
          //   },
          // ),
          // Divider(),
          // SizedBox(height: 10),

          // Tarefas HTTP
          // Pegando POST via API
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.work_outline),
                  const SizedBox(width: 4),
                  Text("Tarefas com HTTP"),
                ],
              )),
            onTap: () async {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TarefaHttpPage()));
            },
          ),
          Divider(),
          SizedBox(height: 10),

          // // Sair
          // InkWell(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          //     width: double.infinity,
          //     child: Row(
          //       children: [
          //         Icon(Icons.exit_to_app),
          //         const SizedBox(width: 4),
          //         Text("Sair"),
          //       ],
          //     )),

          //   // Alert Dialog
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext bc) {
          //         return AlertDialog(
          //           alignment: Alignment.centerLeft,
          //           elevation: 8,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           title: Text(
          //             "APP_TITTLE".tr(),
          //             style: TextStyle(
          //               fontSize: 24,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           content: Wrap(
          //             children:[
          //               Text(
          //                 "Voce está prestes a sair do aplicativo!",
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               const SizedBox(height: 50),
          //               Text(
          //                 "Deseja realmente sair?",
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                 ),
          //               ),
          //             ]
          //           ),
          //           actions: [
          //             TextButton(
          //               onPressed: () {
          //                 Navigator.pop(context);
          //               },
          //               child: Text("Não"),
          //             ),
          //             TextButton(
          //               onPressed: () {
          //                 Navigator.pushReplacement(
          //                   context,
          //                   MaterialPageRoute(
          //                     builder: (context) => LoginPage(),
          //                   )
          //                 );
          //               },
          //               child: Text("Sim"),
          //             ),
          //           ],
          //         );
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}