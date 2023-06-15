import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jaydip_flutter_database/DatabaseTasks/Sqlite/showdatasqlite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../main.dart';

class LoginScreensqlite extends StatefulWidget {
  const LoginScreensqlite({super.key});

  @override
  State<LoginScreensqlite> createState() => _LoginScreensqliteState();
}

class _LoginScreensqliteState extends State<LoginScreensqlite> {
  // List<Map> ldata = <Map>[];
  // late List rolls;
  final _data = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   prevdata();
  //   super.initState();
  // }
  //
  // void prevdata() async {
  //   ldata = await Localdatabase.instance.getAllData();
  //   rolls = ldata.map((e) => e["ID"]).toList();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        'Sqlite Database Use',
        Colors.deepOrange,
      ),
      body: Form(
        key: _data,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: id,
                  decoration: InputDecoration(
                    labelText: 'ID',
                    hintText: 'Enter Your Customer ID',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 3,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Customer ID';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 3,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.name,
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
                    labelText: 'Email id',
                    hintText: 'Enter Your Email id',
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
                        RegExp(r'^[a-zA-z0-9@.]+$'))
                  ],
                  validator: (value) {
                    if (value!.isEmpty)
                      return 'Please Enter Your email id';
                    else
                      return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: age,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    hintText: 'Enter Your Age',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 3,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))
                  ],
                  validator: (value) {
                    if (value!.isEmpty)
                      return 'Please Enter Your age';
                    else
                      return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_data.currentState!.validate()) {
                    int i = await Localdatabase.instance.insertData({
                      Localdatabase.clmid: id.text,
                      Localdatabase.clmname: name.text,
                      Localdatabase.clmemail: email.text,
                      Localdatabase.clmage: age.text,
                    });
                    print(i);
                    setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowdataSqlite(),
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Localdatabase {
  Localdatabase._();

  static final Localdatabase instance = Localdatabase._();

  static const localdbmsname = 'User.db';
  static const tablename = 'DETAIL';
  static const clmid = 'Id';
  static const clmname = 'Name';
  static const clmemail = 'Email_id';
  static const clmage = 'Age';

  static Database? localdbms;

  Future<Database> get getdatabase async {
    if (localdbms != null) return localdbms!;

    localdbms = await initlocaldbms();
    return localdbms!;
  }

  initlocaldbms() async {
    Directory localdir = await getApplicationDocumentsDirectory();
    String path = join(localdir.path, localdbmsname);
    return await openDatabase(path, version: 1, onCreate: OnCreate);
  }

  OnCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE $tablename(
    $clmid INTEGER PRIMARY KEY,
    $clmname TEXT NOT NULL,
    $clmemail TEXT NOT NULL,
    $clmage INTEGER NOT NULL
    )''');
  }

  Future<int> insertData(Map<String, dynamic> data) async {
    Database db = await instance.getdatabase;
    return await db.insert(tablename, data);
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database db = await instance.getdatabase;
    return await db.query(tablename);
  }

  Future<int> updateData(Map<String, dynamic> data) async {
    Database db = await instance.getdatabase;
    int clmId = data[Localdatabase.clmid];
    return await db.update(
      tablename,
      data,
      where: Localdatabase.clmid,
      whereArgs: [clmId],
    );
  }

  Future<int> deleteData(int id) async {
    Database db = await instance.getdatabase;
    return await db.delete(
      tablename,
      where: '$clmid = ?',
      whereArgs: [id],
    );
  }
}
