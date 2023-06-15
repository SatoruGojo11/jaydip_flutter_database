import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'DatabaseTasks/Sqlite/sqlitelogin.dart';

void main() async {
  //This code is only for Hive database Use
  /*WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox<String>('Students');*/
  //This code is only for Firebase database Use
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();*/
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreensqlite(),
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
