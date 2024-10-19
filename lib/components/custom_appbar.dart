import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  // O construtor permite escolher o título e se o botão de voltar será mostrado
  CustomAppBar({required this.title, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.lightBlue.shade100,
      automaticallyImplyLeading: showBackButton, // Controla se o botão de voltar é exibido
      centerTitle: true, // Centraliza o título
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // Altura padrão da AppBar
}
