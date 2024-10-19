import 'package:flutter/material.dart';

class DropdownInputField extends StatelessWidget {
  final String value;
  final List<String> items;
  final void Function(String?)? onChanged;

  DropdownInputField({
    required this.value,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
      items: items
          .map((label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
