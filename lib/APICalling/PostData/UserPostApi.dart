import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserPostApi extends StatefulWidget {
  const UserPostApi({super.key});

  @override
  State<UserPostApi> createState() => _UserPostApiState();
}

class _UserPostApiState extends State<UserPostApi> {
  var vp = TextEditingController();
  var number = TextEditingController();
  var city = TextEditingController();
  var street = TextEditingController();
  var zipcode = TextEditingController();
  var email = TextEditingController();
  var username = TextEditingController();
  var password = TextEditingController();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var phone = TextEditingController();
  var lat = TextEditingController();
  var long = TextEditingController();

  UserPostService service = UserPostService();
  UserPostModel? main;

  @override
  Widget build(BuildContext context) {
    print('Main Screen');
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Data to APi'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: vp,
                decoration: InputDecoration(
                  label: Text('Vp'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: number,
                decoration: InputDecoration(
                  label: Text('Number'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: city,
                decoration: InputDecoration(
                  label: Text('City'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: street,
                decoration: InputDecoration(
                  label: Text('Street'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: zipcode,
                decoration: InputDecoration(
                  label: Text('Zipcode'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  label: Text('Email'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  label: Text('Username'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  label: Text('Password'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: firstname,
                decoration: InputDecoration(
                  label: Text('Firstname'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: lastname,
                decoration: InputDecoration(
                  label: Text('Lastname'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: phone,
                decoration: InputDecoration(
                  label: Text('Phone'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: lat,
                decoration: InputDecoration(
                  label: Text('Latitude'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: TextField(
                controller: long,
                decoration: InputDecoration(
                  label: Text('longitude'),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                print('Elevated Button in Main Screen');
                var data = await service.postdata(
                  vp.text,
                  number.text,
                  city.text,
                  street.text,
                  zipcode.text,
                  email.text,
                  username.text,
                  password.text,
                  firstname.text,
                  lastname.text,
                  phone.text,
                  lat.text,
                  long.text,
                );
                setState(() {
                  print('SetState');
                  main = data as UserPostModel?;
                  print('Main Screen Data == main');
                });
              },
              child: Text('Post Data'),
            ),
            SizedBox(height: 20),
            main == null
                ? Container()
                : Text(
                    '\n VP :- ${main!.vp}\n Number :- ${main!.number} \n City :- ${main!.city}\n Street :- ${main!.street} \n Zipcode :- ${main!.zipcode} \n Email-id :- ${main!.email} \n Username :- ${main!.username} \n Password :- ${main!.password} \n Firstname :- ${main!.firstname} \n Lastname :- ${main!.lastname} \n Phone :- ${main!.phone} \n Username :- ${main!.lat} \n Longitude :- ${main!.long}'),
          ],
        ),
      ),
    );
  }
}


UserPostModel UserFromJson(String str) =>
    UserPostModel.fromJson(json.decode(str));

class UserPostModel {
  int vp, number;
  String city,
      street,
      zipcode,
      email,
      username,
      password,
      firstname,
      lastname,
      phone,
      lat,
      long;

  UserPostModel({
    required this.vp,
    required this.number,
    required this.city,
    required this.street,
    required this.zipcode,
    required this.email,
    required this.username,
    required this.password,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.lat,
    required this.long,
  });

  factory UserPostModel.fromJson(Map<String, dynamic> json) {
    print('Model');
    Map address = json['address'];
    Map geolocation = address['geolocation'];
    Map name = json['name'];
    print('M1');
    var data = UserPostModel(
      vp: json['__v'] ?? 0,
      number: address['number'] ?? 0,
      city: address['city'] ?? 'No data',
      street: address['street'] ?? 'No data',
      zipcode: address['zipcode'] ?? 'No data',
      email: json['email'] ?? 'No data',
      username: json['username'] ?? 'No data',
      password: json['password'] ?? 'No data',
      firstname: name['firstname'] ?? 'No data',
      lastname: name['lastname'] ?? 'No data',
      phone: json['phone'] ?? 'No data',
      lat: geolocation['lat'] ?? 'No data',
      long: geolocation['long'] ?? 'No data',
    );
    return data;
  }
}

class UserPostService {
  Future<UserPostModel> postdata(String vp, number, city, street, zipcode,
      email, username, password, firstname, lastname, phone, lat, long) async {
    var Users = await post(Uri.https('fakestoreapi.com', 'users'), body: {
      'vp': vp,
      'number': number,
      'city': city,
      'street': street,
      'zipcode': zipcode,
      'email': email,
      'username': username,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'lat': lat,
      'long': long,
    });

    print(Users.statusCode);
    if (Users.statusCode == 201) {
      return UserFromJson(Users.body);
    } else {
      throw "Can't load data";
    }
  }
}


