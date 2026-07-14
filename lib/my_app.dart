import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trilhaapp/pages/splash_screen/splash_screen_delay_page.dart';
import 'package:trilhaapp/services/dark_mode_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeService>(
      builder: (context, darkModeService, child) {
        return MaterialApp(
          home: SplashScreenDelayPage(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: darkModeService.darkMode 
            ? ThemeData.dark() 
            : ThemeData(),
          debugShowCheckedModeBanner: false,
        );
      }
    );
  }
}