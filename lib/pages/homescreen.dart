import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamix/pages/browseScreen.dart';
import 'package:streamix/pages/feedScreen.dart';
import 'package:streamix/pages/goLivescreen.dart';
import 'package:streamix/providers/user_provider.dart';
import 'package:streamix/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  onPageChannel(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> page = [
    const FeedScreen(),
    const GoLiveScreen(),
    const Center(
      child: Text("Browser"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: buttonColor,
        unselectedItemColor: primaryColor,
        backgroundColor: backgroundColor,
        onTap: onPageChannel,
        currentIndex: _page,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Following",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_rounded),
            label: "Go Live",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.copy),
            label: "Browse",
          ),
        ],
      ),
      body: page[_page],
    );
  }
}
