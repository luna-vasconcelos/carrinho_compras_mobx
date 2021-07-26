import 'dart:convert';

class Product {
  final String name;
  final String image;
  final String description;
  final double price;
  Product(
    {required this.name,
    required this.image,
    required this.description,
    required this.price});

  Product copyWith({
    String? name,
    String? image,
    String? description,
    double? price,
  }) {
    return Product(
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      image: map['image'],
      description: map['description'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() => 'Product(name: $name, image: $image, description: $description, price: $price)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
     other.name == name && other.image == image && other.description == description && other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ description.hashCode ^ price.hashCode;
}
