import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APICalling extends StatefulWidget {
  const APICalling({super.key});

  @override
  State<APICalling> createState() => _APICallingState();
}

class _APICallingState extends State<APICalling> {
  Map<String, dynamic> users = {};
  List<dynamic> user1 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Api Calling',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: fetchdata,
            icon: Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context,index) => Divider(thickness: 5,),
        itemCount: user1.length,
        itemBuilder: (context, index) {
          try {
            final user = users['name'];
            // final street = users['id'];
            return Padding(
              padding: const EdgeInsets.all(5),
              child: ListTile(
                leading: Text('${index + 1}'),
                title: Text(user),
                // subtitle: Text(street),
              ),
            );
          } catch (e) {
            print(e);
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  void fetchdata() async {
    print('FetchData Called');
    String url = 'https://jsonplaceholder.typicode.com/users';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    // final json = jsonDecode(body);
    setState(() {
      user1 = jsonDecode(body);
      // users = Map.fromEntries(user1.map((e) => ));
    });
    print('FetchData Completed');
  }
}
