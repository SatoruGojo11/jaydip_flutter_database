import 'package:flutter/material.dart';

class ShowdataSqlite extends StatefulWidget {
  const ShowdataSqlite({super.key});

  @override
  State<ShowdataSqlite> createState() => _ShowdataSqliteState();
}

class _ShowdataSqliteState extends State<ShowdataSqlite> {
  // var localdata =

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
            columns: [
              DataColumn(label: Text('Id')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Email-id')),
              DataColumn(label: Text('Age')),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text('')),
                ],
              ),
              DataRow(
                cells: [
                  // DataCell(Text("$localdata")),
                  // DataCell(Text("$localdata")),
                  // DataCell(Text("$localdata")),
                  // DataCell(Text("$localdata")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
