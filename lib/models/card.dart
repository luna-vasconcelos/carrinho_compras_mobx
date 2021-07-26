import 'dart:convert';
import 'package:carrinho_compras/models/product_model.dart';
import 'package:carrinho_compras/utils/extensions.dart';

class CardModel {
  int quantity;
  final Product product;

  String get totalPrice => (quantity * product.price).reais();

  CardModel({
    required this.quantity,
    required this.product,
  });

  CardModel copyWith({
    int? quantity,
    Product? product,
  }) {
    return CardModel(
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'product': product.toMap(),
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      quantity: map['quantity'],
      product: Product.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CardModel.fromJson(String source) =>
      CardModel.fromMap(json.decode(source));

  @override
  String toString() => 'CardModel(quantity: $quantity, product: $product)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CardModel &&
        other.quantity == quantity &&
        other.product == product;
  }

  @override
  int get hashCode => quantity.hashCode ^ product.hashCode;
}