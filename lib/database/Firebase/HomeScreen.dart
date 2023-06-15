import 'package:flutter/material.dart';
import 'package:jaydip_flutter_database/main.dart';

class HomeScreen extends StatefulWidget {
  var _email, _pwd;

  HomeScreen(this._email, this._pwd);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Home Screen', Colors.black87),
      body: Center(
        child: Column(
          children: [
            Text(
              'Home Screen',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              '${widget._email.toString()}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '${widget._pwd.toString()}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
