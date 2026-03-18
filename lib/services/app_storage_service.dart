import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_CHAVES {
  // Tela de Dados cadastrais/ Meu perfil
  chaveDadosCadastraisNome,
  chaveDadosCadastraisDOB,
  chaveDadosCadastraisNivelExp,
  chaveDadosCadastraisLinguagens,
  chaveDadosCadastraisTempoExp,
  chaveDadosCadastraisSalario,

  // Tela de configurações
  chaveNomeUsuario,
  chaveAltura,
  chaveTema,
  chaveNotificacoes,

  // Tela de Numeros Aleatorios
  chaveNumeroAleatorio,
  chaveQuantidadeClicado,
}

class AppStorageService {  
  // STRING
  void _setString(String chave, String value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString(chave, value);
  }
  Future<String> _getString(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(chave) ?? "";
  }

  // STRING LIST
  void _setStringList(String chave, List<String> values) async {
    var storage = await SharedPreferences.getInstance();
    storage.setStringList(chave, values);
  }
  Future<List<String>> _getStringList(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(chave) ?? [];
  }

  // INT
  void _setInt(String chave, int value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setInt(chave, value);
  }
  Future<int> _getInt(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(chave) ?? 0;
  }

  // DOUBLE
  void _setDouble(String chave, double value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setDouble(chave, value);
  }
  Future<double> _getDouble(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(chave) ?? 0.0;
  }

  // BOOL
  void _setBool(String chave, bool value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setBool(chave, value);
  }
  Future<bool> _getBool(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(chave) ?? false;
  }

  /*
  *
  * SETTERS E GETTERS TELA DE DADOS CADASTRAIS / MEU PERFIL
  *
  */
  // Funções de set e get para nome
  Future<void> setDadosCadastraisNome(String nome) async {
    _setString(STORAGE_CHAVES.chaveDadosCadastraisNome.toString(), nome);
  }
  Future<String> getDadosCadastraisNome() async {
    return _getString(STORAGE_CHAVES.chaveDadosCadastraisNome.toString());
  }

  // Funções de set e get para Data de nascimento
  Future<void> setDadosCadastraisDOB(DateTime dob) async {
    _setString(STORAGE_CHAVES.chaveDadosCadastraisDOB.toString(), dob.toString());
  }
  Future<String> getDadosCadastraisDOB() async {
    return _getString(STORAGE_CHAVES.chaveDadosCadastraisDOB.toString());
  }

  // GET SET de Nivel de Exp
  Future<void> setDadosCadastraisNivelExp(String nivelExp) async {
    _setString(STORAGE_CHAVES.chaveDadosCadastraisNivelExp.toString(), nivelExp);
  }
  Future<String> getDadosCadastraisNivelExp() async {
    return _getString(STORAGE_CHAVES.chaveDadosCadastraisNivelExp.toString());
  }

  // GET SET de Linguagens
  Future<void> setDadosCadastraisLinguagens(List<String> linguagens) async {
    _setStringList(STORAGE_CHAVES.chaveDadosCadastraisLinguagens.toString(), linguagens);
  }
  Future<List<String>> getDadosCadastraisLinguagens() async {
    return _getStringList(STORAGE_CHAVES.chaveDadosCadastraisLinguagens.toString());
  }

  // GET SET de Tempo de Exp
  Future<void> setDadosCadastraisTempoExp(int tempoExp) async {
    _setInt(STORAGE_CHAVES.chaveDadosCadastraisTempoExp.toString(), tempoExp);
  }
  Future<int> getDadosCadastraisTempoExp() async {
    return _getInt(STORAGE_CHAVES.chaveDadosCadastraisTempoExp.toString());
  }

  // GET SET de Pretensão Salarial
  Future<void> setDadosCadastraisSalario(double salario) async {
    _setDouble(STORAGE_CHAVES.chaveDadosCadastraisSalario.toString(), salario);
  }
  Future<double> getDadosCadastraisSalario() async {
    return _getDouble(STORAGE_CHAVES.chaveDadosCadastraisSalario.toString());
  }

  /*
  *
  * SETTERS E GETTERS TELA DE CONFIGURAÇÕES
  *
  */
  Future<void> setConfiguracesNomeUsuario(String nome) async {
    _setString(STORAGE_CHAVES.chaveNomeUsuario.toString(), nome);
  }
  Future<String> getConfiguracoesNomeUsuario() async {
    return _getString(STORAGE_CHAVES.chaveNomeUsuario.toString());
  }

  Future<void> setConfiguracoesAltura(double altura) async {
    _setDouble(STORAGE_CHAVES.chaveAltura.toString(), altura);
  }
  Future<double> getConfiguracoesAltura() async {
    return _getDouble(STORAGE_CHAVES.chaveAltura.toString());
  }

  Future<void> setConfiguracoesTemaEscuro(bool temaEscuro) async {
    _setBool(STORAGE_CHAVES.chaveTema.toString(), temaEscuro);
  }
  Future<bool> getConfiguracoesTemaEscuro() async {
    return _getBool(STORAGE_CHAVES.chaveTema.toString());
  }

  Future<void> setConfiguracoesReceberNotificacao(bool receberNotificacao) async {
    _setBool(STORAGE_CHAVES.chaveNotificacoes.toString(), receberNotificacao);
  }
  Future<bool> getConfiguracoesReceberNotificacao() async {
    return _getBool(STORAGE_CHAVES.chaveNotificacoes.toString());
  }

  /*
  *
  * SETTERS E GETTERS TELA DE NUMEROS ALEATORIOS
  *
  */
  Future<void> setNumeroAleatorio(int rngNumber) async {
    _setInt(STORAGE_CHAVES.chaveNumeroAleatorio.toString(), rngNumber);
  }
  Future<int> getNumeroAleatorio() async {
    return _getInt(STORAGE_CHAVES.chaveNumeroAleatorio.toString());
  }

  Future<void> setQuantidadeCliques(int qtdCliques) async {
    _setInt(STORAGE_CHAVES.chaveQuantidadeClicado.toString(), qtdCliques);
  }
  Future<int> getQuantidadeCliques() async {
    return _getInt(STORAGE_CHAVES.chaveQuantidadeClicado.toString());
  }
}