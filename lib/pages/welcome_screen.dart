import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../widgets/customButton.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({super.key});
  final routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to \nStreamix",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: customButton(
                  onTap: () {},
                  text: "Log In",
                ),
              ),
              customButton(
                onTap: () {},
                text: "Sign In",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
