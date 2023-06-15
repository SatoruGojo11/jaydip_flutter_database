import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../main.dart';

class HiveUse extends StatefulWidget {
  const HiveUse({super.key});

  @override
  State<HiveUse> createState() => _HiveUseState();
}

class _HiveUseState extends State<HiveUse> {
  Box<String>? dataBox;

  var id = TextEditingController();
  var name = TextEditingController();

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
                    final value = data.get(key);
                    return ListTile(
                      title: Text(
                        value.toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        key.toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
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
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(controller: id),
                          SizedBox(height: 10),
                          TextField(controller: name),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              dataBox!.put(id.text, name.text);
                              Navigator.pop(context);
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Text('ADD'),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(controller: id),
                          SizedBox(height: 10),
                          TextField(controller: name),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              dataBox!.put(id.text, name.text);
                              Navigator.pop(context);
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Text('UPDATE'),
              ),
              ElevatedButton(
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
                child: Text('DELETE'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
