import 'package:calculo_calorias/screens/splash_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(CalculoCaloriasApp());
}

class CalculoCaloriasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Calorias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
