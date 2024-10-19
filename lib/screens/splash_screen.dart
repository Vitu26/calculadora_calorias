import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'result_screen.dart';
import 'input_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String mensagemBoasVindas = "Bem-vindo!"; // Mensagem padrão
  bool _temCache = false; // Flag para verificar se há cache

  @override
  void initState() {
    super.initState();
    _verificarCache(); // Verifica o cache ao iniciar
  }

  Future<void> _verificarCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? resultadoCalorias = prefs.getString('resultado_calorias');

    await Future.delayed(Duration(seconds: 2)); // Atraso para exibir a splash screen

    if (resultadoCalorias != null) {
      setState(() {
        mensagemBoasVindas = "Bem-vindo de volta!"; // Atualiza a mensagem
        _temCache = true;
      });

      // Redireciona para a tela de resultados
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen(resultado: resultadoCalorias)),
      );
    } else {
      // Redireciona para a tela de entrada de dados
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InputScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_fire_department, // Ícone do app ou qualquer ícone de sua escolha
                  size: 100, // Tamanho do ícone
                  color: Colors.blueAccent, // Cor do ícone
                ),
                SizedBox(height: 20),
                Text(
                  mensagemBoasVindas, // Exibe a mensagem de boas-vindas
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Indicador de progresso (CircularProgressIndicator)
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
