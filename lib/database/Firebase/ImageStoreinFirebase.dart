import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaydip_flutter_database/main.dart';

class ImageStoreinFirebase extends StatefulWidget {
  const ImageStoreinFirebase({super.key});

  @override
  State<ImageStoreinFirebase> createState() => _ImageStoreinFirebaseState();
}

class _ImageStoreinFirebaseState extends State<ImageStoreinFirebase> {
  ImagePicker imagePicker = ImagePicker();
  Reference reference = FirebaseStorage.instance.ref();
  String? imageurl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Image Store in Firebase', Colors.black87),
      body: ListView(
        children: [
          IconButton(
            onPressed: pickImageFromCamera,
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 50,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          imageurl == null ? Placeholder() : Image.network(imageurl!),
        ],
      ),
    );
  }

  pickImageFromCamera() async {
    XFile? ImageData = await imagePicker.pickImage(source: ImageSource.camera);
    var image = reference.child('Image');
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    var imageId = image.child(id);
    await imageId.putFile(File(ImageData!.path));

    imageurl = await imageId.getDownloadURL();
    setState(() {});
  }
}
