import 'package:flutter/material.dart';

import '../../main.dart';
import 'DBHelperSqlite.dart';

class SqliteUse extends StatefulWidget {
  const SqliteUse({super.key});

  @override
  State<SqliteUse> createState() => _SqliteUseState();
}

class _SqliteUseState extends State<SqliteUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        'Sqlite Database Use',
        Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                int i = await Dbhelper.instance.insertData(
                  {
                    Dbhelper.clmname: 'Jaydip',
                    Dbhelper.clmemail: 'jay@gmail.com',
                    Dbhelper.clmage: '20'
                  },
                );
                print(i);
              },
              child: Text('Insert'),
            ),
            ElevatedButton(
              onPressed: () async {
                List<Map<String, dynamic>> i =
                    await Dbhelper.instance.getAllData();
                print(i);
              },
              child: Text('Get'),
            ),
            ElevatedButton(
              onPressed: () async {
                int i = await Dbhelper.instance.updateData({
                  Dbhelper.clmid: 2,
                  Dbhelper.clmname: 'Divyang',
                  Dbhelper.clmemail: 'divu12@gmail.com',
                  Dbhelper.clmage: '21'
                });
                print(i);
              },
              child: Text('Update'),
            ),
            ElevatedButton(
              onPressed: () async {
                int i = await Dbhelper.instance.deleteData(2);
                print(i);
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
