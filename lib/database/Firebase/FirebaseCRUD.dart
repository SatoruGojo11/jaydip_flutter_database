import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jaydip_flutter_database/database/Firebase/HomeScreen.dart';
import 'package:jaydip_flutter_database/main.dart';

class FirebaseCrudApp extends StatefulWidget {
  const FirebaseCrudApp({super.key});

  @override
  State<FirebaseCrudApp> createState() => _FirebaseCrudAppState();
}

class _FirebaseCrudAppState extends State<FirebaseCrudApp> {
  var idctrl = TextEditingController();
  var namectrl = TextEditingController();
  var agectrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Curd Operation', Colors.deepOrange),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: idctrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Id'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: namectrl,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: agectrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addData();
                Map<String, dynamic> data = {
                  'Id': idctrl.text,
                  'Name': namectrl.text,
                  'Age': agectrl.text,
                };
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreendata(data),
                  ),
                );
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  addData() {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('Students').doc(idctrl.text);

    Map<String, dynamic> data = {
      'Id': idctrl.text,
      'Name': namectrl.text,
      'Age': agectrl.text,
    };

    reference.set(data).whenComplete(() => print('Add Successful'));
  }

  readData() {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('Students').doc(idctrl.text);

    reference.get().then((value) {
      print(value.get('Id'));
      print(value.get('Name'));
      print(value.get('Age'));
    });
  }

  updateData() {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('Students').doc(idctrl.text);

    Map<String, dynamic> data = {
      'Id': idctrl.text,
      'Name': namectrl.text,
      'Age': agectrl.text,
    };

    reference.update(data).whenComplete(() => print('Updated Successful'));
  }

  deleteData() {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('Students').doc(idctrl.text);

    reference.delete().whenComplete(() => print('Deleted Successful'));
  }
}
