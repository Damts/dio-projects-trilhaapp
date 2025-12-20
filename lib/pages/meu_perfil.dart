import 'package:flutter/material.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import 'package:trilhaapp/repositories/nivel_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class MeuPerfil extends StatefulWidget {

  const MeuPerfil({super.key});

  @override
  State<MeuPerfil> createState() => _MeuPerfilState();
}

class _MeuPerfilState extends State<MeuPerfil> {
  TextEditingController nomeController = TextEditingController(text: "");
  TextEditingController dobController = TextEditingController(text: "");
  DateTime? dataNascimento;

  var nivelRepository = NivelRepository();
  var niveis = [];
  var nivelSelecionado = "";

  var linguagensRepository = LinguagensRepository();
  var linguagens = [];
  var linguagensSelecionadas = [];

  double salarioEscolhido = 0;
  int tempoExperiencia = 0;

  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornLinguagens();
    super.initState();
  }

  // Lista de componentes
  List<DropdownMenuItem<int>> returnItens(int quantidadeMaxima) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i <= quantidadeMaxima; i++) {
      itens.add(
          DropdownMenuItem(
          value: i,
          child: Text(i.toString()),
        ),
      );
    }
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Meus Dados",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: salvando 
            ? Center(child: CircularProgressIndicator()) 
            : ListView(
              children: [
                // Nome
                TextLabel(texto: "Nome"),
                TextField(
                  controller: nomeController,
                ),
                
                // Data de Nascimento
                TextLabel(texto: "Data de Nascimento"),
                TextField(
                  controller: dobController,
                  readOnly: true,
                  onTap: () async {
                    var data = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900, 1, 1), 
                      lastDate: DateTime(2030, 12, 31),
                    );
                    if (data != null) {
                      dobController.text = data.toString();
                      dataNascimento = data;
                    }
                  },
                ),

                // Nivel de Experiencia
                TextLabel(texto: "Nivel de Experiencia"),
                Column(
                  children: niveis.map((nivel) => 
                      RadioListTile(
                        dense: false, //diminui a fonte e aproxima as opções
                        title: Text(nivel.toString()),
                        selected: nivelSelecionado == nivel,
                        value: nivel,
                        groupValue: nivelSelecionado,
                        onChanged: (value) {
                          setState(() {
                            nivelSelecionado = value.toString();
                          });
                          print(nivelSelecionado);
                        },
                      ),
                    ).toList(),
                ),

                // Linguagens preferidas
                TextLabel(texto: "Linguagens Preferidas"),
                Column(
                  children: linguagens.map((linguagem) => 
                    CheckboxListTile(
                      dense: false, //compacta as opções
                      title: Text(linguagem),
                      value: linguagensSelecionadas.contains(linguagem), 
                      onChanged: (value) {
                        if (value == true) {
                          setState(() {
                            value = true;
                            linguagensSelecionadas.add(linguagem);
                          });
                        } else {
                          setState(() {
                            value = false;
                            linguagensSelecionadas.remove(linguagem);
                          });
                        }
                      },
                    ),
                  ).toList(),
                ),

                // Tempo de Experiencia
                TextLabel(texto: "Tempo de Experiencia"),
                DropdownButton(
                  value: tempoExperiencia, //Valor que ira exibir no campo
                  isExpanded: true, // Coloca o icone no final
                  items: returnItens(50),
                  onChanged: (value) {
                    setState(() {
                      tempoExperiencia = int.parse(value.toString());
                    });
                  },
                ),

                // Pretensão Salarial
                TextLabel(texto: "Pretensão Salarial R\$ ${salarioEscolhido.round()}"),
                Slider(
                  min: 0,
                  max: 10000,
                  value: salarioEscolhido, 
                  onChanged: (double value) {
                    setState(() {
                      salarioEscolhido = value;
                    });
                  },
                ),

                // Botão Salvar
                TextButton(
                  onPressed: () {
                    setState(() {
                      salvando = false;
                    });
                    if (nomeController.text.trim().length < 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Nome deve ser preenchido e ter mais de 3 caracteres"),
                          backgroundColor: Colors.red,
                        )
                      );
                      return;
                    }
                    if (dataNascimento == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Selecione uma data de nascimento"),
                          backgroundColor: Colors.red,
                        )
                      );
                      return;
                    }
                    if (nivelSelecionado.trim() == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Selecione um nivel de experiencia"),
                          backgroundColor: Colors.red,
                        )
                      );
                      return;
                    }
                    if (linguagensSelecionadas.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Selecione pelo menos uma linguagem."),
                          backgroundColor: Colors.red,
                        )
                      );
                      return;
                    }
                    // Não obrigatorio
                    if (tempoExperiencia == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Deve ter ao menos um ano de experiencia."),
                          backgroundColor: Colors.red,
                        )
                      );
                      return;
                    }
                    
                    if (salarioEscolhido == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Informe a pretensão salarial."),
                          backgroundColor: Colors.red,
                        )
                      );
                      return;
                    }

                    setState(() {
                      salvando = true;
                    });
                    
                    // Aplica um delay de determinado tempo e depois executa uma ação
                    Future.delayed(
                      Duration(seconds: 2), 
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Dados salvos com sucesso."),
                            backgroundColor: Colors.green,
                          )
                        );
                        setState(() {
                          salvando = false;
                        });
                        Navigator.pop(context); // Fecha a tela após salvar
                      }
                    );
                  }, 
                  child: Text("Salvar"),
                )
              ],
            ),
        ),
      ),
    );
  }
}