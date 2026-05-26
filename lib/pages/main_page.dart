import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/calculadora_imc/calculadora_imc.dart';
import 'package:trilhaapp/pages/calculadora_imc/calculadora_imc_sqlite_page.dart';
import 'package:trilhaapp/pages/card_page.dart';
import 'package:trilhaapp/pages/image_assets.dart';
import 'package:trilhaapp/pages/list_view.dart';
import 'package:trilhaapp/pages/list_view_horizontal.dart';
import 'package:trilhaapp/pages/tarefa_page/tarefa_hive_page.dart';
import 'package:trilhaapp/pages/tarefa_page/tarefa_sqlite_page.dart';
import 'package:trilhaapp/pages/consulta_cep.dart';
import 'package:trilhaapp/shared/widgets/custom_drawer.dart';

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
        drawer: CustomDrawer(),

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
                  ConsultaCep(),
                  CardPage(),
                  // ImageAssetsPage(),
                  ListViewPage(),
                  ListViewHorizontalPage(),
                  TarefaSQLitePage(),
                  CalculadoraImcSQLitePage(),
                ],
              ),
            ),

            // Bottom Navigation bar
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed, // Utilizar quando 4+ Itens
              currentIndex: paginaSelecionada,
              onTap: (value) {
                setState(() {
                  pageController.jumpToPage(value);
                });
              },
              items: [
                BottomNavigationBarItem(
                  label: "HTTP",
                  icon: Icon(Icons.get_app_rounded),
                ),
                BottomNavigationBarItem(
                  label: "Card",
                  icon: Icon(Icons.airplane_ticket),
                ),
                BottomNavigationBarItem(
                  label: "ListView",
                  icon: Icon(Icons.newspaper),
                ),
                BottomNavigationBarItem(
                  label: "Lista",
                  icon: Icon(Icons.list),
                ),
                BottomNavigationBarItem(
                  label: "Tarefas",
                  icon: Icon(Icons.task),
                ),
                BottomNavigationBarItem(
                  label: "Calculadora IMC",
                  icon: Icon(Icons.calculate)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}