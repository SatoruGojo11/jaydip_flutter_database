import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductsPostApi extends StatefulWidget {
  const ProductsPostApi({super.key});

  @override
  State<ProductsPostApi> createState() => _ProductsPostApiState();
}

class _ProductsPostApiState extends State<ProductsPostApi> {
  var title = TextEditingController();
  // var price = TextEditingController();
  // var description = TextEditingController();
  // var category = TextEditingController();
  // var image = TextEditingController();
  // var rate = TextEditingController();
  // var count = TextEditingController();

  ProductPostService ppservice = ProductPostService();
  ProductPostModel? main;

  @override
  Widget build(BuildContext context) {
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
                controller: title,
                decoration: InputDecoration(
                  label: Text('Title'),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(7),
            //   child: TextField(
            //     controller: price,
            //     decoration: InputDecoration(
            //       label: Text('Price'),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(7),
            //   child: TextField(
            //     controller: description,
            //     decoration: InputDecoration(
            //       label: Text('Description'),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(7),
            //   child: TextField(
            //     controller: category,
            //     decoration: InputDecoration(
            //       label: Text('Category'),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(7),
            //   child: TextField(
            //     controller: image,
            //     decoration: InputDecoration(
            //       label: Text('Image'),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(7),
            //   child: TextField(
            //     controller: rate,
            //     decoration: InputDecoration(
            //       label: Text('Rate'),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(7),
            //   child: TextField(
            //     controller: count,
            //     decoration: InputDecoration(
            //       label: Text('Count'),
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var data = await ppservice.postdata(
                    // count.text,
                    title.text
                    // description.text,
                    // category.text,
                    // image.text,
                    // price.text,
                    // rate.text
                );
                setState(() {
                  main = data;
                  print('Main Screen Data = main');
                });
              },
              child: Text('Post Data'),
            ),
            SizedBox(height: 20),
            main == null
                ? Container()
                : Column(
                    children: [
                      Text(
                          '\n Title :- ${main!.title}'
                        // \n Price :- ${main!.price}\n Description :- ${main!.description} \n Category :- ${main!.category} \n Count :- ${main!.ratingcount.toString()} \n Rate :- ${main!.rate.toString()}'
                          ),
                      // Image.network(main!.image),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

ProductPostModel ProductsFromJson(String str) =>
    ProductPostModel.fromJson(json.decode(str));

class ProductPostModel {
  int ratingcount;
  String title, description, category, image;
  double price, rate;

  ProductPostModel({
    required this.ratingcount,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    required this.rate,
  });

  factory ProductPostModel.fromJson(Map<String,dynamic> json) {
    print('Model 1');
    Map ratings = json['rating'];
    print('Model 2');
    var products = ProductPostModel(
      title: json["title"] ?? 'No data',
      price: json["price"].toDouble() ?? 0.0,
      description: json["description"] ?? 'No data',
      category: json["category"] ?? 'No data',
      image: json["image"] ?? 'No data',
      ratingcount: ratings['count'] ?? 0,
      rate: ratings['rate'].toDouble() ?? 0.0,
    );
    print('Model 3');
    return products;
  }
}

class ProductPostService {
  // Future<ProductPostModel> postdata(String title, description, category, image, price, rate,
  //     ratingcount) async {
    Future<ProductPostModel> postdata(String title) async {
    var products = await post(
      Uri.https('fakestoreapi.com', 'products'),
      body:
      {
        "title": title,
        // "price": price,
        // "description": description,
        // "category": category,
        // "image": image,
        // "rate": ratingcount,
        // "count": rate,
      },
    );

    print(products.statusCode);
    if (products.statusCode == 201) {
      return ProductsFromJson(products.body);

      // List<dynamic> body = jsonDecode(products.body);
      //
      // List<ProductPostModel> dataList = body.map((e) {
      //   var temp = ProductPostModel.fromJson(e);
      //   return temp;
      // }).toList();

      // return dataList;
    } else {
      throw "Can't load Data";
    }
  }
}
