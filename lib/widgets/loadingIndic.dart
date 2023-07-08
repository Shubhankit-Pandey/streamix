import 'package:flutter/material.dart';

class LoadingIndic extends StatelessWidget {
  const LoadingIndic({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
