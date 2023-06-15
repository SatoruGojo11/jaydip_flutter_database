import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jaydip_flutter_database/DatabaseTasks/SharedPreference/showdatascreensharedpref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class LoginPageUsingSharedPref extends StatefulWidget {
  const LoginPageUsingSharedPref({Key? key}) : super(key: key);

  @override
  State<LoginPageUsingSharedPref> createState() =>
      _LoginPageUsingSharedPrefState();
}

class _LoginPageUsingSharedPrefState extends State<LoginPageUsingSharedPref> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();
  var _data = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        'Login Page',
        Colors.black87,
      ),
      body: Center(
        child: Form(
          key: _data,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.red),
                      hintText: 'Enter Your Name',
                      hintStyle: TextStyle(color: Colors.red.withOpacity(0.8)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 3,
                        ),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-z]+$'))
                    ],
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'Please Enter Your name';
                      else
                        return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'Email-id',
                      labelStyle: TextStyle(color: Colors.red),
                      hintText: 'Enter Your Email id',
                      hintStyle: TextStyle(color: Colors.red.withOpacity(0.8)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 3,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^[0-9a-z@.]+$'),
                      ),
                    ],
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'Please Enter Your email id ';
                      else
                        return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: pwd,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.red),
                      hintText: 'Enter Your Password',
                      hintStyle: TextStyle(color: Colors.red.withOpacity(0.8)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 3,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^[0-9A-Za-z@$#]+$'),
                      ),
                    ],
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'Please Enter Your Password';
                      else
                        return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_data.currentState!.validate()) {
                      adddata();
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowdataScreensharedpref(),
                          ),
                        );
                      });
                    }
                  },
                  child: Text('Add Data'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  adddata() async {
    final getdt = await SharedPreferences.getInstance();
    getdt.setString('name', name.text);
    getdt.setString('emailid', email.text);
    getdt.setString('password', pwd.text);
  }
}
