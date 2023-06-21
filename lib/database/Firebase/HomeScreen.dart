import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class HomeScreendata extends StatefulWidget {
  final Map show;

  HomeScreendata(this.show);

  @override
  State<HomeScreendata> createState() => _HomeScreendataState();
}

class _HomeScreendataState extends State<HomeScreendata> {
  List ids = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    data = await FirebaseFirestore.instance
        .collection('Students')
        .get()
        .then((value) => value.docs);

    for (var element in data!) {
      ids.add(element.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Home Screen', Colors.black87),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Name :- ${widget.show['Name']}'),
              leading: Text('${widget.show['Id']}'),
              subtitle: Text('Age :- ${widget.show['Age']}'),
            );
          },
          // itemCount: widget.show.length,
        ),
      ),
    );
  }
}
