import 'dart:convert';

Map<String, Product> productFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, Product>(k, Product.fromJson(v)));

String productToJson(Map<String, Product> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Product {
  bool available;
  String name;
  String? picture;
  double price;
  String? id;

  Product(
      {required this.available,
      required this.name,
      this.picture,
      required this.price,
      this.id});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };

  Product copy() => Product(
      available: available, name: name, picture: picture, price: price, id: id);
}
