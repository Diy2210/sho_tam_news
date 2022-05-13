import 'package:flutter/material.dart';
import 'package:sho_tam/NewsScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: NewsScreen(),
      routes: {
        NewsScreen.routeName: (ctx) => NewsScreen(),
      }
    );
  }
}