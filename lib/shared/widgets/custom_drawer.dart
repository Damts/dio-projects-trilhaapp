import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/meu_perfil_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: Border(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('lib/assets/images/eren-mikasa.png'),
              ),
              accountName: Text("Mateus Soares"), 
              accountEmail: Row(
                children: [
                  Text("email@email.com"),
                ],
              ),
            ),
          ),
          Divider(),
          SizedBox(height: 10),
      
          // Meu Perfil
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.person),
                  Text("Meu Perfil"),
                ],
              )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => const MeuPerfilPage(),
                ),
              );
            },
          ),
          SizedBox(height: 10),
      
          // Configurações
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.settings),
                  Text("Configurações"),
                ],
              )),
            onTap: () {},
          ),
          SizedBox(height: 10),
      
          // Termos de Uso
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.rule),
                  Text("Termos de uso e Privacidade"),
                ],
              )),
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                context: context, 
                builder: (BuildContext bc) {
                  return SafeArea(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      child: Column(
                        children: [
                          Text(
                            "Termos de Privacidade",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec urna nisi, auctor sed scelerisque eu, consectetur id velit. Suspendisse vulputate odio enim, vitae maximus nisi interdum vitae. Nulla facilisi. Pellentesque malesuada nulla sapien, vitae mattis eros ultrices nec. Sed ac odio lectus. Praesent dignissim eros odio, ut varius elit vehicula pellentesque.",
                            style: TextStyle(
                              fontSize: 18
                            ),
                            // Alinhar Texto
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              );
            },
          ),
          Divider(),
          SizedBox(height: 10),
      
          // Sair
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.exit_to_app),
                  Text("Sair"),
                ],
              )),

            // Alert Dialog
            onTap: () {
              showDialog(
                context: context, 
                builder: (BuildContext bc) {
                  return AlertDialog(
                    alignment: Alignment.centerLeft,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      "Meu App", 
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Wrap(
                      children:[ 
                        Text(
                          "Voce está prestes a sair do aplicativo!",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Text(
                          "Deseja realmente sair?",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ]
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, 
                        child: Text("Não"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            )
                          );
                        }, 
                        child: Text("Sim"),
                      ),
                    ],
                  );
              });
            },
          ),
        ],
      ),
    );
  }
}