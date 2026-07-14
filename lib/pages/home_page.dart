import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart' as APP_TITLE;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trilhaapp/pages/brasil_fields/brasil_fields_page.dart';
import 'package:trilhaapp/pages/contador_page/contador_page.dart';
import 'package:trilhaapp/pages/tarefa_page/tarefa_provider_page.dart';
import 'package:trilhaapp/services/dark_mode_service.dart';
import 'package:trilhaapp/shared/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text(
            "APP_TITLE".tr(),
            style: GoogleFonts.roboto(),
          ),
          actions: [
            Center(child: Text("Dark")),
            Consumer<DarkModeService>(
              builder: (context, darkModeService, child) {
                return Switch(
                  value: darkModeService.darkMode,
                  onChanged: (bool value) {
                    darkModeService.darkMode = !darkModeService.darkMode;
                  },
                );
              }
            ),
          ],
          backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.purple : Colors.blue,
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            ContadorPage(),
            TarefaProviderPage(),
            Container(color: Colors.green),
            Container(color: Colors.yellow),
            BrasilFieldsPage(),
          ],
        ),
        // Convex Bar para uma navigation bar mais bonita
        bottomNavigationBar: ConvexAppBar.badge(
          // Badge para colocar números acima dos ícones
          {0: '99+', 1: Icons.assistant_photo, 2: Colors.redAccent},
          onTap: (int idx) {
            tabController.index = idx;
          },
          controller: tabController,
          items: [
            TabItem(
              title: "Home",
              icon: Icons.home,
            ),
            TabItem(
              title: "Perfil",
              icon: Icons.person,
            ),
            TabItem(
              title: "Adicionar",
              icon: Icons.add,
            ),
            TabItem(
              title: "Forum",
              icon: Icons.forum,
            ),
            TabItem(
              title: "Brasil",
              icon: Icons.flag,
            ),
          ],
        ),
      ),
    );
  }
}