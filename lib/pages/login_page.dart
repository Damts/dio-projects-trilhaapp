import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email = "";
  String senha = "";
  bool isPasswordHiden = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea( // Para trabalhar com area segura no mobile
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: Container()
                    ),

                    // Imagem Logo
                    Expanded(
                      flex: 8,
                      child: Image.network(
                        "https://lpunderground.com/LPU_share_image.v2.jpg", 
                      ),
                    ),

                    Expanded(
                      child:  Container()
                    ),

                  ],
                ),
                const SizedBox(height: 20),

                const Text(
                  "Já tem cadastro?",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                const Text(
                  "Faça seu login",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // Email
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: emailController,
                    onChanged: (value) {
                      debugPrint(value);
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.only(top: 0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                        )
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.pink),
                      hintText: "E-mail: email",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ),
                const SizedBox(height: 15),

                // Senha
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: TextField(
                    obscureText: isPasswordHiden, //esconde a digitação
                    controller: senhaController,
                    onChanged: (value) {
                      debugPrint(value);
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.only(top: 0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.pink),
                      hintText: "Senha: 1234",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      suffixIcon: InkWell( //Pode-se usar GestureDetector tambem
                        onTap: () {
                          setState(() {
                            isPasswordHiden = !isPasswordHiden;
                          });
                        },
                        child: Icon(
                          isPasswordHiden ? Icons.visibility_off : Icons.visibility,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  )
                ),
                const SizedBox(height: 30),

                // Botão Entrar
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        if (emailController.text.trim() == "email" && senhaController.text.trim() == "1234") {
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => const MainPage()
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Erro ao efetuar login"),
                              backgroundColor: Colors.red,
                            )
                          );
                        }
                      }, 
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.amber),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: Text(
                        "ENTRAR",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ),
                  )
                ),
                Expanded(child: Container()),

                // Esqueci minha senha
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                //Criar conta
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    "Criar conta",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}