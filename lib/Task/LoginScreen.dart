import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _data = GlobalKey<FormState>();

  var name = TextEditingController();
  var email = TextEditingController();
  var age = TextEditingController();
  var phoneno = TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  Reference reference = FirebaseStorage.instance.ref();
  String? galleryimg, imageurl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Login Screen',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black38,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 30),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  maxRadius: 70,
                  backgroundColor: Colors.brown[900],
                  child: imageurl == null
                      ? Icon(
                          Icons.account_circle,
                          size: 130,
                          color: Colors.amber,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(imageurl!),
                                fit: BoxFit.cover),
                          ),
                        ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.teal,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            color: Colors.teal,
                            height: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Pick Your Image :- ',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 5, color: Colors.black87),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(25),
                                        child: GestureDetector(
                                          onTap: pickCameraImage,
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.camera_alt_outlined,
                                                size: 60,
                                                color: Colors.amber,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Camera',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black87,
                                        border: Border.all(
                                            width: 5, color: Colors.black87),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(25),
                                        child: GestureDetector(
                                          onTap: pickGallaryImage,
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.image,
                                                size: 60,
                                                color: Colors.amber,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Gallery',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Form(
              key: _data,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onTapOutside: (event) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      ),
                      controller: name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[A-Za-z]+$')),
                      ],
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration: textfielddecor('Enter Your Name', 'Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your name';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: email,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[0-9A-Za-z@._]+$')),
                      ],
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration:
                          textfielddecor('Enter Your Emaid id', 'Email-id'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Email id';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: age,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
                      ],
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration: textfielddecor('Enter Your Age', 'Age'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Age';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: phoneno,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
                      ],
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration:
                          textfielddecor('Enter Your Phone No.', 'Phone No.'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Phone No.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Save Data'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Show Data'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  pickCameraImage() async {
    XFile? imagedata = await imagePicker.pickImage(source: ImageSource.camera);
    var image = reference.child('Task');
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    var imageId = image.child(id);
    await imageId.putFile(
      File(imagedata!.path),
    );

    imageurl = await imageId.getDownloadURL();
    setState(() {
      Navigator.pop(context);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Photo Uploaded Successfully....',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  pickGallaryImage() async {
    XFile? imagedata = await imagePicker.pickImage(source: ImageSource.gallery);
    var image = reference.child('Task');
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    var imageId = image.child(id);
    await imageId.putFile(
      File(imagedata!.path),
    );

    imageurl = await imageId.getDownloadURL();
    setState(() {
      Navigator.pop(context);
    });
    await ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Photo Uploaded Successfully....',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  image() async {
    var data = {
      imageurl == null
          ? Icon(Icons.account_circle, size: 130, color: Colors.orange)
          : Image.network(imageurl!)
    };
    setState(() {});
    return await data;
  }

  textfielddecor(label, hint) {
    var decoration = InputDecoration(
      filled: true,
      fillColor: Colors.amber,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.brown,
          )),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Colors.brown,
        ),
      ),
      labelText: '${label}',
      hintText: '${hint}',
      labelStyle: TextStyle(
        color: Colors.brown[900],
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      hintStyle: TextStyle(
        color: Colors.brown[900],
        fontSize: 20,
      ),
    );

    return decoration;
  }
}
