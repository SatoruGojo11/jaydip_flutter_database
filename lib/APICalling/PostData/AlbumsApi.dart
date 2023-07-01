import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AlbumsPostApi extends StatefulWidget {
  const AlbumsPostApi({super.key});

  @override
  State<AlbumsPostApi> createState() => _AlbumsPostApiState();
}

class _AlbumsPostApiState extends State<AlbumsPostApi> {
  var titlecontroller = TextEditingController();

  AlbumsPostService service = AlbumsPostService();
  AlbumsPostModel? main;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums Api'),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          TextField(
            controller: titlecontroller,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              var data = await service.postdata(titlecontroller.text);
              setState(() {
                main = data;
              });
            },
            child: Text('Post Data'),
          ),
          SizedBox(height: 30),
          main == null
              ? Container(color: Colors.red)
              : Text('Your id is ${main!.id} & Title is ${main!.title}'),
        ],
      ),
    );
  }
}

AlbumsPostModel AlbumsFromJson(String str) =>
    AlbumsPostModel.fromJson(json.decode(str));

class AlbumsPostModel {
  int userId;
  int id;
  String title;

  AlbumsPostModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory AlbumsPostModel.fromJson(Map<String, dynamic> json) =>
      AlbumsPostModel(
        userId: json["userId"] ?? 0,
        id: json["id"],
        title: json["title"],
      );
}

class AlbumsPostService {
  Future<AlbumsPostModel> postdata(String title) async {
    var albums = await post(
      Uri.https('jsonplaceholder.typicode.com', 'albums'),
      body: {'title': title},
    );

    if (albums.statusCode == 201) {
      return AlbumsFromJson(albums.body);
    } else {
      throw Exception("Can't load data");
    }
  }
}
