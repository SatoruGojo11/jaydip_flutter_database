import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:jaydip_flutter_database/main.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorage2nd extends StatefulWidget {
  const FirebaseStorage2nd({super.key});

  @override
  State<FirebaseStorage2nd> createState() => _FirebaseStorage2ndState();
}

class _FirebaseStorage2ndState extends State<FirebaseStorage2nd> {
  late Future<ListResult> futureFiles;

  Map<int, double> downloadProgress = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/movies').listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Firebase yt', Colors.black87),
      body: FutureBuilder(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                double? progress = downloadProgress[index];

                return ListTile(
                  title: Text(file.name),
                  subtitle: progress != null
                      ? LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.deepOrange,
                        )
                      : null,
                  trailing: IconButton(
                    onPressed: () => downloadfile(index, file),
                    icon: Icon(Icons.download,color: Colors.black87,),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error Occured'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future downloadfile(int index, Reference ref) async {
    //Only Seen in the App
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');

    await ref.writeToFile(file);

    // for saving data in phone's Gallary
    final url = await ref.getDownloadURL();

    final tempdir = await getTemporaryDirectory();
    final path = '${tempdir.path}/${ref.name}';
    await Dio().download(url, path, onReceiveProgress: (received, total) {
      double progress = received / total;
      setState(() {
        downloadProgress[index] = progress;
      });
    });

    if (url.contains('.mkv')) {
      await GallerySaver.saveVideo(path, toDcim: true);
    } else if (url.contains('.jpeg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloaded ${ref.name}'),
      ),
    );
  }
}
