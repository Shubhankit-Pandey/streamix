import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../widgets/customButton.dart';
import './login.dart';
import './signup.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({super.key});
  static const String routeName = '/welcome';

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
                  onTap: () {
                    Navigator.pushNamed(context, Login.routeName);
                  },
                  text: "Log In",
                ),
              ),
              customButton(
                onTap: () {
                  Navigator.pushNamed(context, SignUp.routeName);
                },
                text: "Sign Up",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
