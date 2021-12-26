import 'package:flutter/material.dart';
import 'package:hola/src/screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
    title: "Usando la camara con Flutter",
    home: HomeScreen(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.red,
      accentColor: Colors.red,
    ),
  );
  }
}