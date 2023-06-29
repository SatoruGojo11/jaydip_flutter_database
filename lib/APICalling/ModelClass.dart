class ProductModel {
  final int id, ratingcount;
  final String title, description, category, image;
  final double price, rate;

  ProductModel({
    required this.id,
    required this.ratingcount,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    required this.rate,
  });

  factory ProductModel.fromJson(Map jsonData) {
    print('Model');
    Map ratings = jsonData['rating'];
    print('M1');
    var data = ProductModel(
      id: jsonData['id'] ?? 0,
      ratingcount: ratings['count'] ?? 0,
      title: jsonData['title'] ?? 'No data',
      description: jsonData['description'] ?? 'No data',
      category: jsonData['category'] ?? 'No data',
      image: jsonData['image'] ?? 'No data',
      price: jsonData['price'].toDouble() ?? 0.0,
      rate: ratings['rate'].toDouble() ?? 0.0,
    );
    print('ML');
    return data;
  }
}

class UsersModel {
  final int id, vp, number;
  final String city,
      street,
      zipcode,
      email,
      username,
      password,
      firstname,
      lastname,
      phone,lat, long;

  UsersModel({
    required this.id,
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

  factory UsersModel.fromJson(Map jsonData) {
    print('Model');
    Map address = jsonData['address'];
    Map geolocation = address['geolocation'];
    Map name = jsonData['name'];
    print('M1');
    var data = UsersModel(
      id: jsonData['id'] ?? 0,
      vp: jsonData['__v'] ?? 0,
      number: address['number'] ?? 0,
      city: address['city'] ?? 'No data',
      street: address['street'] ?? 'No data',
      zipcode: address['zipcode'] ?? 'No data',
      email: jsonData['email'] ?? 'No data',
      username: jsonData['username'] ?? 'No data',
      password: jsonData['password'] ?? 'No data',
      firstname: name['firstname'] ?? 'No data',
      lastname: name['lastname'] ?? 'No data',
      phone: jsonData['phone'] ?? 'No data',
      lat: geolocation['lat'] ?? 'No data',
      long: geolocation['long'] ?? 'No data',
    );
    print('ML');
    return data;
  }
}
