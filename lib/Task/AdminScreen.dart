import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'UserData.dart';

class AdminData extends StatefulWidget {
  const AdminData({super.key});

  @override
  State<AdminData> createState() => _AdminDataState();
}

class _AdminDataState extends State<AdminData> {
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
            'Admin Panel',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => getAllData(),
              icon: Icon(Icons.refresh_outlined),
            ),
          ],
          backgroundColor: Colors.black38,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(thickness: 5),
            itemCount: alldata.length,
            itemBuilder: (context, index) {
              try {
                return ListTile(
                  tileColor: Colors.amber,
                  title: Text(
                    'Name :- ${alldata[index].get('Name')}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.brown[900]),
                  ),
                  subtitle: Text(
                    'Email-id :- ${alldata[index].get('Email-id')}',
                    style: TextStyle(fontSize: 15, color: Colors.brown[900]),
                  ),
                  leading: CircleAvatar(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                NetworkImage('${alldata[index].get('Image')}'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  onTap: () {
                    // var Name = alldata[index].get('Name');
                    // var Email = alldata[index].get('Name');
                    // var Age = alldata[index].get('Name');
                    // var Phone = alldata[index].get('Name');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserData(
                                name: '${alldata.first.get('Name')}',
                                email: '${alldata.first.get('Email-id')}',
                                age: '${alldata.first.get('Age')}',
                                phno: '${alldata.first.get('Phone')}',
                              )),
                    );
                  },
                );
              } catch (e) {
                return CircularProgressIndicator();
              }
            },
          ),
        ));
  }
}
