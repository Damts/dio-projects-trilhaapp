import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/meu_perfil.dart';
import 'package:trilhaapp/pages/pagina1.dart';
import 'package:trilhaapp/pages/pagina2.dart';
import 'package:trilhaapp/pages/pagina3.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  PageController pageController = PageController(initialPage: 0);
  int paginaSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Main Page", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ), 
          backgroundColor: Colors.blue,
        ),

        // Drawer
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.person, size: 60),
                Divider(),
                SizedBox(height: 10),

                // Meu Perfil
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
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
                        builder: (context) => const MeuPerfil(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),

                // Configurações
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
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
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.rule),
                        Text("Termos de uso e Privacidade"),
                      ],
                    )),
                  onTap: () {},
                ),
                Divider(),
                SizedBox(height: 10),

                // Sair
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        Text("Sair"),
                      ],
                    )),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),

        // Body
        body: Column(
          children: [

            // Page View
            Expanded(
              child: PageView(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  setState(() {
                    paginaSelecionada = value; 
                  });
                },
                children: [
                  Pagina1(),
                  Pagina2(),
                  Pagina3(),
                ],
              ),
            ),

            // Bottom Navigation bar
            BottomNavigationBar(
              currentIndex: paginaSelecionada,
              onTap: (value) {
                setState(() {
                  pageController.jumpToPage(value);
                });
              },
              items: [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: "Tickets",
                  icon: Icon(Icons.airplane_ticket),
                ),
                BottomNavigationBarItem(
                  label: "Newsletter",
                  icon: Icon(Icons.newspaper),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}