import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/main_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black87, Colors.purple],
              stops: [0.3, 0.9], //Pode ser feito com varios stops contanto que tenha varias colors
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Type Writer
                // AnimatedTextKit(
                //   animatedTexts: [
                //     TypewriterAnimatedText(
                //       'Bem vindo ao Meu App',
                //       textStyle: const TextStyle(
                //         fontSize: 32.0,
                //         fontWeight: FontWeight.bold,
                //       ),
                //       speed: const Duration(milliseconds: 200),
                //     ),
                //   ],
                //   onFinished: () {
                //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const MainPage()));
                //   },
                //   totalRepeatCount: 4,
                //   repeatForever: false,
                //   pause: const Duration(milliseconds: 100),
                //   displayFullTextOnTap: true,
                //   stopPauseOnTap: true,
                //   // controller: myAnimatedTextController,
                // ),

                // Fade
                SizedBox(
                  width: 250.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      repeatForever: false,
                      animatedTexts: [
                        FadeAnimatedText('Meu App!'),
                        FadeAnimatedText('Em Flutter!!'),
                        FadeAnimatedText('Pela DIO!!!'),
                      ],
                      onFinished: () {
                        if (!mounted) return;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const LoginPage()));
                      },
                      onTap: () {
                        debugPrint("Tap Event");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}