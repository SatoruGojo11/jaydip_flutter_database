import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {

  final phoneno;
  MainScreen(this.phoneno);
  // const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var name,emailid,age,phno;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Main Screen',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.teal,
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: Text('${name}'),
            )
          ],
        )
      ),
    );
  }

  getData() {
    DocumentReference reference =
    FirebaseFirestore.instance.collection('Task').doc(widget.phoneno.text);

    reference.get().then((value) => {
      name = value.get('Name'),
      emailid = value.get('Email-id'),
      age = value.get('Age'),
      phno = value.get('Name'),
    });
  }

}
