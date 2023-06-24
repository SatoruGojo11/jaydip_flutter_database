import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'MainScreen.dart';

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
  String? imageurl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Register Screen',
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
                            RegExp(r'^[0-9a-z@._]+$')),
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[900]),
                  onPressed: () {
                    if (_data.currentState!.validate() &&
                        imageurl!.isNotEmpty) {
                      addData();
                      showsnkreg(context);
                    } else {
                      showsnkimg(context);
                    }
                    setState(() {});
                    // name.clear();
                    // email.clear();
                    // age.clear();
                    // phoneno.clear();
                  },
                  child: Text(
                    'Save Data',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[900]),
                  onPressed: () {
                    if (imageurl != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                      );
                    } else {
                      Text('Please Select Profile Photo...');
                    }
                  },
                  child: Text(
                    'Show Data',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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

  showsnkreg(context) {
    var snk = SnackBar(
      content: Text('Registeration Successful..'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snk);
  }

  showsnkimg(context) {
    var snk = SnackBar(
      content: Text('Profile Photo Required'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snk);
  }

  addData() {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('Task').doc(phoneno.text);

    Map<String, dynamic> data = {
      'Name': name.text,
      'Email-id': email.text,
      'Age': age.text,
      'Phone': phoneno.text,
    };

    reference.set(data).whenComplete(() => print('Save Data Successfully'));
  }
}
