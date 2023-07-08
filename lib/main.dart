import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamix/pages/signup.dart';
import 'package:streamix/providers/user_provider.dart';
import 'package:streamix/resources/auth_methods.dart';
import 'package:streamix/widgets/loadingIndic.dart';
import './pages/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import './resources/auth_methods.dart';
import './utils/colors.dart';
import './pages/login.dart';
import './pages/homescreen.dart';
import './models/user.dart' as model;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Streamix",
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: backgroundColor,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: const IconThemeData(
            color: primaryColor,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        welcomeScreen.routeName: (context) => const welcomeScreen(),
        Login.routeName: (context) => const Login(),
        SignUp.routeName: (context) => const SignUp(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
      home: FutureBuilder(
        future: AuthMethods()
            .getCurrentuser(FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.uid
                : null)
            .then((value) {
          if (value != null) {
            Provider.of<UserProvider>(context, listen: false).setUser(
              model.User.fromMap(value),
            );
          }
          return value;
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndic();
          }

          if (snapshot.hasData) {
            return HomeScreen();
          }

          return welcomeScreen();
        },
      ),
    );
  }
}
