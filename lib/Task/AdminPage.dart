import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'AdminScreen.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  var data = GlobalKey<FormState>();

  TextEditingController Email = TextEditingController();
  TextEditingController Pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Admin Page',
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: data,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: Email,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[0-9a-z@._]+$')),
                      ],
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration:
                          textfielddecor('Enter Your Email-id', 'Email-id'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          if (value.toString() != 'jaydip12@gmail.com') {
                            return 'Your Email id is wrong';
                          } else {
                            return 'Please Enter Your Email-id';
                          }
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: Pwd,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[0-9A-Za-z@._#*]+$')),
                      ],
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration:
                          textfielddecor('Enter Your Password', 'Password'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          if (value.toString() != 'CrudJaydip@12') {
                            return 'Your Password is wrong';
                          } else {
                            return 'Please Enter Your Password';
                          }
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.brown[900]),
              onPressed: () {
                if (data.currentState!.validate()) {
                  showsnk('Login Successfull',Colors.green);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminData(),),);
                }
                setState(() {});
              },
              child: Text(
                'Log in',
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  textfielddecor(label, hint) {
    var decoration = InputDecoration(
      filled: true,
      fillColor: Colors.amber,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.brown,
          )),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Colors.brown,
        ),
      ),
      labelText: '${label}',
      hintText: '${hint}',
      labelStyle: TextStyle(
        color: Colors.brown[900],
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      hintStyle: TextStyle(
        color: Colors.brown[900],
        fontSize: 20,
      ),
    );

    return decoration;
  }

  showsnk(msg, color) {
    var snk = SnackBar(
      content: Text(
        '${msg}',
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snk);
  }
}
