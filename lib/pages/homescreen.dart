import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamix/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Center(
        child: Text(
          userProvider.user.username,
        ),
      ),
    );
  }
}
