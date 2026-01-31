import 'package:flutter/material.dart';
import 'package:trilhaapp/shared/widgets/app_images.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    // ListView e ListTile
    return ListView( // Visualização em Lista
      children: [
        // Bloco de Lista
        ListTile(
          //Adiciona algo antes de tudo
          leading: Image.asset(AppImages.colin), 
          title: Text('Colin'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("I can Hear the Future"),
              Text("03:59")
            ],
          ),
          //Adiciona algo depois de tudo
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {
              if(menu == "opcao2"){
                debugPrint("Selecionada a Opção 2");           
              }
            },
            itemBuilder: (BuildContext bc) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem(
                  value: "opcao1",
                  child: Text("Opção 1")
                ),
                PopupMenuItem(
                  value: "opcao2",
                  child: Text("Opção 2")
                ),
                PopupMenuItem(
                  value: "opcao3",
                  child: Text("Opção 3")
                ),
              ];
            },  
          ), 
          isThreeLine: false, // Para caso o subtitle ocupe mais de uma linha
        ),
        Image.asset(
          AppImages.colin
        ),
        Image.asset(
          AppImages.erenMikasa
        ),
        Image.asset(
          AppImages.stew
        ),
        Image.asset(
          AppImages.momoKen
        ),
        Image.asset(
          AppImages.lpu
        ),
        Image.asset(
          AppImages.luminosity
        ),
      ],
    );
  }
}