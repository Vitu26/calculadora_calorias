import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  ActionButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF42A5F5), // Cor inicial do gradiente
              Color(0xFF478DE0), // Cor intermediária
              Color(0xFF3F51B5), // Cor final do gradiente
            ],
            begin: Alignment.topLeft, // Direção inicial do gradiente
            end: Alignment.bottomRight, // Direção final do gradiente
          ),
          borderRadius: BorderRadius.circular(8), // Bordas arredondadas
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Deixa o botão transparente
            shadowColor: Colors.transparent, // Remove a sombra
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Bordas do botão
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
