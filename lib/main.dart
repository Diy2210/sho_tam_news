import 'package:flutter/material.dart';
import 'package:sho_tam/screens/AppSplashScreen.dart';
import 'package:sho_tam/screens/NewsScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Шо там?',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const AppSplashScreen(),
      routes: {
        AppSplashScreen.routeName: (ctx) => const AppSplashScreen(),
        NewsScreen.routeName: (ctx) => const NewsScreen(),
      }
    );
  }
}