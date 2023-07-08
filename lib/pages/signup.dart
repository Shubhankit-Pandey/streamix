import 'package:flutter/material.dart';
import 'package:streamix/resources/auth_methods.dart';
import 'package:streamix/widgets/customButton.dart';
import '../widgets/customTextfield.dart';
import './homescreen.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  void signUpuser() async {
    bool res = await _authMethods.signUpuser(
      context,
      _emailcontroller.text,
      _usernamecontroller.text,
      _passwordcontroller.text,
    );

    if (res) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SignUp",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              const Text(
                "Email",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: customTextfield(controller: _emailcontroller),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: customTextfield(controller: _passwordcontroller),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Username",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: customTextfield(controller: _usernamecontroller),
              ),
              const SizedBox(
                height: 20,
              ),
              customButton(onTap: signUpuser, text: "SignUp")
            ],
          ),
        ),
      ),
    );
  }
}
