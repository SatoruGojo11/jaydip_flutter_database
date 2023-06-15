import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jaydip_flutter_database/main.dart';

class FirebaseCrudApp extends StatefulWidget {
  const FirebaseCrudApp({super.key});

  @override
  State<FirebaseCrudApp> createState() => _FirebaseCrudAppState();
}

class _FirebaseCrudAppState extends State<FirebaseCrudApp> {
  var id = TextEditingController();
  var name = TextEditingController();
  var age = TextEditingController();

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
              controller: id,
              decoration: InputDecoration(labelText: 'Id'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: age,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 20),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    addData();
                    setState(() {
                      id.clear();
                      name.clear();
                      age.clear();
                    });
                  },
                  child: Text('Add'),
                ),
                ElevatedButton(
                  onPressed: () {
                    readData();
                    setState(() {
                      id.clear();
                      name.clear();
                      age.clear();
                    });
                  },
                  child: Text('Read'),
                ),
                ElevatedButton(
                  onPressed: () {
                    updateData();
                    setState(() {
                      id.clear();
                      name.clear();
                      age.clear();
                    });
                  },
                  child: Text('Update'),
                ),
                ElevatedButton(
                  onPressed: () {
                    deleteData();
                    setState(() {
                      id.clear();
                      name.clear();
                      age.clear();
                    });
                  },
                  child: Text('Delete'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  addData() {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('Students').doc(id.text);

    Map<String, dynamic> data = {
      'Id': id.text,
      'Name': name.text,
      'Age': age.text,
    };

    reference.set(data).whenComplete(() => print('Add Successful'));
  }

  readData() {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('Students').doc(id.text);

    reference.get().then((value) {
      print(value.get('Id'));
      print(value.get('Name'));
      print(value.get('Age'));
    });
  }

  updateData() {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('Students').doc(id.text);

    Map<String, dynamic> data = {
      'Id': id.text,
      'Name': name.text,
      'Age': age.text,
    };

    reference.update(data).whenComplete(() => print('Updated Successful'));
  }

  deleteData() {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('Students').doc(id.text);

    reference.delete().whenComplete(() => print('Deleted Successful'));
  }
}
