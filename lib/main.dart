import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'APICalling/UserApi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserApi(),
      /*theme: ThemeData(
        scaffoldBackgroundColor: Colors.black87,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.amber,
        ),
      ),*/
    ),
  );
}

appbar(txt, bgcolor) {
  var apb = AppBar(
    centerTitle: true,
    title: Text(
      '$txt',
      style: TextStyle(
        fontSize: 20,
        color: bgcolor,
      ),
    ),
  );
  return apb;
}
