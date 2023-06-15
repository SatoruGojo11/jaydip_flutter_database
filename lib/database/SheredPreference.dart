import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SharedPreferenceUse extends StatefulWidget {
  const SharedPreferenceUse({Key? key}) : super(key: key);

  @override
  State<SharedPreferenceUse> createState() => _SharedPreferenceUseState();
}

class _SharedPreferenceUseState extends State<SharedPreferenceUse> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Shared Preference App', Colors.black87),
      body: Center(
        child: Text(
          '$_counter',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }

  incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }

  loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }
}
