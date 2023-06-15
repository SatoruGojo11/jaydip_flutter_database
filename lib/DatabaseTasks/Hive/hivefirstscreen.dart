import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../main.dart';

class HiveFirstScreen extends StatefulWidget {
  const HiveFirstScreen({super.key});

  @override
  State<HiveFirstScreen> createState() => _HiveFirstScreenState();
}

class _HiveFirstScreenState extends State<HiveFirstScreen> {
  Box<String>? dataBox;

  var id = TextEditingController();
  var name = TextEditingController();
  var course = TextEditingController();
  var sem = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataBox = Hive.box('Students');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Hive Database App', Colors.black87),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: dataBox!.listenable(),
              builder: (context, data, _) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final key = data.keys.toList()[index];
                    final name = data.get(key);
                    final course = data.get(key);
                    final sem = data.get(key);
                    return ListTile(
                      title: Text(
                        name.toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Text(
                        key.toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        children: [
                          Text(
                            course.toString(),
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            sem.toString(),
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    thickness: 3,
                  ),
                  itemCount: data.length,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(controller: id,decoration: InputDecoration(labelText: 'Id'),),
                          SizedBox(height: 10),
                          TextField(controller: name,decoration: InputDecoration(labelText: 'Name'),),
                          SizedBox(height: 10),
                          TextField(controller: course,decoration: InputDecoration(labelText: 'Course'),),
                          SizedBox(height: 10),
                          TextField(controller: sem,decoration: InputDecoration(labelText: 'Sem'),),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              dataBox!.put(id.text,
                                  '${name.text}, ${course.text},${sem.text}');
                              Navigator.pop(context);
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(controller: id,decoration: InputDecoration(labelText: 'Id'),),
                          SizedBox(height: 10),
                          TextField(controller: name,decoration: InputDecoration(labelText: 'Name'),),
                          SizedBox(height: 10),
                          TextField(controller: course,decoration: InputDecoration(labelText: 'Course'),),
                          SizedBox(height: 10),
                          TextField(controller: sem,decoration: InputDecoration(labelText: 'Sem'),),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              dataBox!.put(
                                id.text,
                                '${name.text},${course.text},${sem.text}',
                              );
                              Navigator.pop(context);
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.autorenew),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(controller: id),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              dataBox!.delete(id.text);
                              Navigator.pop(context);
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
