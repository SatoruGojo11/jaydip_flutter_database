import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> alldata = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  getAllData() async {
    alldata =
        await FirebaseFirestore.instance.collection('Task').get().then((value) {
      return value.docs;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'User Data',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black38,
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Image.network('${alldata.first.get('Image')}'),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Name :- ${alldata.first.get('Name')}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.amber),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Email-id :- ${alldata.first.get('Email-id')}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.amber),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Age :- ${alldata.first.get('Age')}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.amber),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Phone No.:- ${alldata.first.get('Phone')}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.amber),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[900]),
                    onPressed: () {},
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[900]),
                    onPressed: () {},
                    child: Text(
                      'Delete',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
