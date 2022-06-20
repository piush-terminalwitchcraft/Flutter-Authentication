import 'package:flutter/material.dart';
import 'package:flutter_authentication/pages/home.dart';
import 'package:flutter_authentication/pages/login.dart';
import 'package:flutter_authentication/pages/register.dart';
import 'package:flutter_authentication/utils/AppRoutes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_authentication/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepOrange,
        ).copyWith(secondary: Colors.orange),
      ),
      themeMode: ThemeMode.light,
      routes: {
        "/": (context) => Login(),
        Approutes.HomeRoute: (context) => Home(),
        Approutes.LoginRoute: (context) => Login(),
        Approutes.RegisterRoute: (context) => Register(),
      },
      initialRoute: Approutes.LoginRoute,
    );
  }
}
