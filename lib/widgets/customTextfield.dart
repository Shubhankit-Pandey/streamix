import 'package:flutter/material.dart';
import '../utils/colors.dart';

class customTextfield extends StatelessWidget {
  final TextEditingController controller;
  const customTextfield({required this.controller, super.key});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: buttonColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: secondarybackgroundColor,
          ),
        ),
      ),
    );
  }
}
