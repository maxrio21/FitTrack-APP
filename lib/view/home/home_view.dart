//home_view
import "package:flutter/material.dart";
import 'package:fittrack/data/session_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    try {
      String? loadedToken = await SessionManager.getToken();
      print('Loaded Token: $loadedToken');
      setState(() {
        token = loadedToken;
      });
    } catch (e) {
      print('Error loading token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [Text('Token: $token')],
      ),
    );
  }
}