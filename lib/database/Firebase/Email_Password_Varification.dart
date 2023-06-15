import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jaydip_flutter_database/main.dart';
import 'HomeScreen.dart';

class Emailpassverify extends StatefulWidget {
  const Emailpassverify({super.key});

  @override
  State<Emailpassverify> createState() => _EmailpassverifyState();
}

class _EmailpassverifyState extends State<Emailpassverify> {
  var _email = TextEditingController();
  var _pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Email & Password Verification', Colors.black87),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _email,
              decoration: InputDecoration(labelText: 'Email id'),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _pwd,
              decoration: InputDecoration(labelText: 'Password'),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _email.text, password: _pwd.text);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error Found :- $e'),
                    backgroundColor: Colors.black87,
                  ),
                );
              }
            },
            child: Text('SIGN IN'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _email.text, password: _pwd.text);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Error Found :- $e',
                      style: TextStyle(color: Colors.red),
                    ),
                    backgroundColor: Colors.black87,
                  ),
                );
              }
              setState(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(_email.text, _pwd.text),
                  ),
                );
              });
            },
            child: Text('SIGN UP'),
          ),
        ],
      ),
    );
  }
}
