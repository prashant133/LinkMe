import 'package:flutter/material.dart';

class StyleText extends StatelessWidget {
  const StyleText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'LinkMe',
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        height: 3,
      ),
    );
  }
}
