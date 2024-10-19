import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode; // O próximo campo a ser focado

  TextInputField({
    required this.controller,
    required this.inputType,
    this.validator,
    required this.currentFocusNode,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      textInputAction: nextFocusNode != null
          ? TextInputAction.next
          : TextInputAction.done, // Mostra "Next" ou "Done" dependendo do próximo input
      focusNode: currentFocusNode, // Associa o campo com o FocusNode atual
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
      validator: validator,
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode); // Muda para o próximo foco
        } else {
          currentFocusNode.unfocus(); // Fecha o teclado no último campo
        }
      },
    );
  }
}
