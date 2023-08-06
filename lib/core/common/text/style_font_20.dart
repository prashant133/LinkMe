import 'package:flutter/material.dart';

class TextStyle1 extends StatelessWidget {
  const TextStyle1({required this.text, required this.colors, super.key});

  final Color colors;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        height: 1.5,
      ).copyWith(color: colors),
    );
  }
}
