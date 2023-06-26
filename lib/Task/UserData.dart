import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UserData extends StatefulWidget {

  final String name, email, age, phno;

  UserData(
      {super.key,
      required this.name,
      required this.email,
      required this.age,
      required this.phno});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> alldata = [];

  var Data = GlobalKey<FormState>();

  var Name = TextEditingController();
  var Email = TextEditingController();
  var Age = TextEditingController();
  var Phoneno = TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  Reference reference = FirebaseStorage.instance.ref();
  String? imageurl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  getAllData() async {
    alldata =
        await FirebaseFirestore.instance.collection('Task').get().then((value) {
      return value.docs;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'User Data',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black38,
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            try {
              return Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Image.network('${alldata[index].get('Image')}'),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        'Name :- ${alldata[index].get('Name')}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.amber),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        'Email-id :- ${alldata[index].get('Email-id')}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.amber),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        'Age :- ${alldata[index].get('Age')}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.amber),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        'Phone No.:- ${alldata[index].get('Phone')}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.amber),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown[900]),
                            onPressed: () => updatedata(),
                            child: Text(
                              'Edit',
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
                              deleteData();
                              showsnk('Data Deleted', Colors.red);
                              Navigator.of(context).pop(context);
                              setState(() {});
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } catch (e) {
              return CircularProgressIndicator();
            }
          },
        ));
  }

  updatedata() {
    var edit = showModalBottomSheet(
        backgroundColor: Colors.orangeAccent.withOpacity(0.5),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Update Data',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.brown[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                                    width: 5,
                                                    color: Colors.black87),
                                              ),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(25),
                                                child: GestureDetector(
                                                  onTap: pickCameraImage,
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .camera_alt_outlined,
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
                                                            FontWeight
                                                                .bold),
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
                                                    width: 5,
                                                    color: Colors.black87),
                                              ),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(25),
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
                                                            FontWeight
                                                                .bold),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: Data,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: Name,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[A-Za-z]+$')),
                              ],
                              cursorColor: Colors.white,
                              style:
                              TextStyle(color: Colors.black, fontSize: 20),
                              decoration:
                              textfielddecor('Enter Your Name', 'Name'),
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
                              controller: Email,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9a-z@._]+$')),
                              ],
                              cursorColor: Colors.white,
                              style:
                              TextStyle(color: Colors.black, fontSize: 20),
                              decoration: textfielddecor(
                                  'Enter Your Emaid id', 'Email-id'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  if (Email.toString() != '@') {
                                    return 'Please Enter Right Gmail id';
                                  } else {
                                    return 'Please Enter Your Email id';
                                  }
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: Age,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]+$')),
                              ],
                              cursorColor: Colors.white,
                              style:
                              TextStyle(color: Colors.black, fontSize: 20),
                              decoration:
                              textfielddecor('Enter Your Age', 'Age'),
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
                              controller: Phoneno,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]+$')),
                              ],
                              cursorColor: Colors.white,
                              style:
                              TextStyle(color: Colors.black, fontSize: 20),
                              decoration: textfielddecor(
                                  'Enter Your Phone No.', 'Phone No.'),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  if (Phoneno.text.length != 10) {
                                    return 'Please Enter 10 Digit Phone No.';
                                  } else {
                                    return 'Please Enter Your Phone No.';
                                  }
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.brown[900]),
                              onPressed: () {
                                if (Data.currentState!.validate() &&
                                    imageurl!.isNotEmpty) {
                                  DocumentReference reference =
                                  FirebaseFirestore.instance
                                      .collection('Task')
                                      .doc(widget.phno);

                                  Map<String, dynamic> data = {
                                    'Image': imageurl,
                                    'Name': Name.text,
                                    'Email-id': Email.text,
                                    'Age': Age.text,
                                    'Phone': Phoneno.text,
                                  };

                                  reference.update(data).whenComplete(
                                          () => print('Save Data Successfully'));
                                  setState(() {});
                                  showsnk('Data Updated', Colors.green);
                                }
                                imageurl = null;
                                Name.clear();
                                Email.clear();
                                Age.clear();
                                Phoneno.clear();
                                setState(() {});
                              },
                              child: Text(
                                'Update',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        });
    return edit;
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

  showsnk(msg, color) {
    var snk = SnackBar(
      content: Text(
        '${msg}',
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snk);
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
    setState(() {});
    Navigator.of(context).pop(context);

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
    setState(() {});
    Navigator.of(context).pop(context);

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

  deleteData() async {
    Reference docimg = await FirebaseStorage.instance
        .ref()
        .child('Task')
        .child('${alldata.first.get('Image')}');
    docimg.delete().whenComplete(() => print('Image Delete Successfull'));
    var docdata =
    await FirebaseFirestore.instance.collection('Task').doc(widget.phno);
    docdata.delete().whenComplete(() => print('Data Delete Successfull'));
    setState(() {});
  }
}

/*
 Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Image.network('${alldata.first.get('Image')}'),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Name :- ${alldata.first.get('Name')}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.amber),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Email-id :- ${alldata.first.get('Email-id')}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.amber),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Age :- ${alldata.first.get('Age')}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.amber),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Phone No.:- ${alldata.first.get('Phone')}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.amber),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[900]),
                    onPressed: () {},
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[900]),
                    onPressed: () {},
                    child: Text(
                      'Delete',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),*/
