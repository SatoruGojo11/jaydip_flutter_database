import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowdataScreensharedpref extends StatefulWidget {
  const ShowdataScreensharedpref({super.key});

  @override
  State<ShowdataScreensharedpref> createState() => _ShowdataScreensharedprefState();
}

class _ShowdataScreensharedprefState extends State<ShowdataScreensharedpref> {
  String customername = "";
  String customeremail = "";
  String customerpwd = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showdata();
    // setState(() {});
  }

  showdata() async {
    final getdata = await SharedPreferences.getInstance();
    customername = await getdata.getString('name')!;
    customeremail = await getdata.getString('emailid')!;
    customerpwd = await getdata.getString('password')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Showdata', Colors.black87),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.account_circle,
                        size: 60,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Name :- $customername',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Email id :- $customeremail',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Password :- $customerpwd',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              margin: EdgeInsets.all(15),
              elevation: 10.0,
              borderOnForeground: true,
            ),
          ],
        ),
      ),
    );
  }
}
