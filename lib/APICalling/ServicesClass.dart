import 'dart:convert';
import 'package:http/http.dart';
import 'package:jaydip_flutter_database/APICalling/ModelClass.dart';

class ProductServices {
  static Future<List<ProductModel>> getData() async {
    var products = await get(Uri.https('fakestoreapi.com', 'products'));
    print('Product Service');

    if (products.statusCode == 200) {
      print('S1');
      List<dynamic> body = jsonDecode(products.body);
      print('S2');
      List<ProductModel> dataList = body.map((e) {
        var data = ProductModel.fromJson(e);
        return data;
      }).toList();
      //List<ProductModel> dataList = body.map((e) => ProductModel.fromJson(e) ).toList();
      print('S3');
      return dataList;
    } else {
      throw "Can't get Data";
    }
  }
}


class UserServices {
  Future<List> getData() async {
    var users = await get(Uri.https('fakestoreapi.com', 'users'));
    print(users.statusCode);
    if (users.statusCode == 200) {
      print('Services');
      List<dynamic> body = jsonDecode(users.body);
      print('Service 1');
      // List dataList = [];
      // print(dataList);
      // body.forEach((element) {
      //   var temp = UsersModel.fromJson(jsonData: element);
      //   dataList.add(temp);
      //   print(dataList);
      // });
      List<UsersModel> dataList = body.map((e) {
        print('Variable making');
        var temp = UsersModel.fromJson(e);
        print('Variable Completed...');
        return temp;
      }).toList();
      print('Service 2');
      print(dataList);
      return dataList;
    } else
      throw Exception("Can't get Data");
  }
}

/*

1. https://fakestoreapi.com/products

var abc = [
      {
        "id": 1,
        "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        "price": 109.95,
        "description":
            "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        "category": "men's clothing",
        "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        "rating": {"rate": 3.9, "count": 120}
      },
    ];

2. https://fakestoreapi.com/users


List a = [
  {
    "address": {
      "geolocation": {"lat": "-37.3159", "long": "81.1496"},
      "city": "kilcoole",
      "street": "new road",
      "number": 7682,
      "zipcode": "12926-3874"
    },
    "id": 1,
    "email": "john@gmail.com",
    "username": "johnd",
    "password": "m38rmF$",
    "name": {"firstname": "john", "lastname": "doe"},
    "phone": "1-570-236-7033",
    "__v": 0
  },
];
 */
