import 'package:flutter/material.dart';
import '../utils/colors.dart';

class customButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const customButton({
    required this.onTap,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          minimumSize: const Size(double.infinity, 40)),
      onPressed: onTap,
      child: Text(text),
    );
  }
}
