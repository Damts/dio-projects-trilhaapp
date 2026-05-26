import 'package:flutter/material.dart';
import 'package:trilhaapp/models/marvel/characters_model.dart';
import 'package:trilhaapp/repositories/marvel/marvel_repository.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  ScrollController _scrollController  = ScrollController();
  late MarvelRepository marvelRepository;
  CharactersModel characters = CharactersModel();
  int offset = 0;
  bool _isLoading = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      var posicaoParaPaginar = _scrollController.position.maxScrollExtent * 0.7;
      if (posicaoParaPaginar < _scrollController.position.pixels) {
        debugPrint('Carregando pagina');
        _carregarDados();
      }
      print(_scrollController.position.pixels);
      print(_scrollController.position.maxScrollExtent);
    });
    marvelRepository = MarvelRepository();
    _carregarDados();
    super.initState();
  }

  void _carregarDados() async {
    if (_isLoading) return;
    if (characters.data == null || characters.data!.results == null) {
      debugPrint('Carrega primeiros herois');
      characters = await marvelRepository.getCharacters(offset);
    } else {
      setState(() {
        _isLoading = true;
      });
      debugPrint('Carrega mais herois');
      offset = characters.data!.count!;
      var tempList = await marvelRepository.getCharacters(offset);
      characters.data!.results!.addAll(tempList.data!.results!);
    }
    setState(() {
      _isLoading = false;
    });
  }

  int retornaQuantidadeAtual() {
    try {
      return offset + characters.data!.count!;
    } catch (e) {
      return 10; // Com API funcionando deixar 0
    }
  }

  int retornaQuantidadeTotal() {
    try {
      return characters.data!.total!;
    } catch (e) {
      return 100; // Com API funcionando deixar 0
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('HEROIS: ${retornaQuantidadeAtual()}/${retornaQuantidadeTotal()}'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: (characters.data == null || characters.data!.results == null)
                  ? 10 // Com API funcionando aqui fica 0
                  : characters.data!.results!.length,
                itemBuilder: (_, index) {
                  var character = characters.data?.results?[index];
                  Image image;
                  if (character != null && character.thumbnail != null) {
                    image = Image.network("${character.thumbnail!.path!}.${character.thumbnail!.extension!}");
                  } else {
                    image = Image.asset('lib/assets/images/colin.jpg');
                  }
                  return Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: image,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nome Heroi ${character?.name}', 
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,  
                                  ),
                                ),
                                Text('Descrição Heroi ${character?.description}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            !_isLoading ? ElevatedButton(
              onPressed: () {
                _carregarDados();
              }, 
              child: Text("Carregar mais"),
            ) : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}