import 'package:carrinho_compras/models/card.dart';
import 'package:carrinho_compras/models/product_model.dart';
import 'package:carrinho_compras/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'cart_controller.g.dart';

class CartController = _CartControllerBase with _$CartController;

abstract class _CartControllerBase with Store {
  @observable
  ObservableList<CardModel> list = ObservableList.of(<CardModel>[]);

  @observable
  String listLength = "0";

  @observable
  String cartPrice = "0.0";

  @action
  void addItem(Product product) {
    if (list.any((element) => element.product == product)) {
      final _index = list.indexWhere((element) => element.product == product);
      final _cardModel = list[_index];
      list[_index] = _cardModel.copyWith(quantity: _cardModel.quantity + 1);
    } else {
      list.add(CardModel(product: product, quantity: 1));
    }
    attListSize();
  }

  @action
  void removeItem(Product product) {
    if (list.any((element) => element.product == product)) {
      final _index = list.indexWhere((element) => element.product == product);
      if (list[_index].quantity > 1) {
        final _CardModel = list[_index];
        list[_index] = _CardModel.copyWith(quantity: _CardModel.quantity - 1);
      } else {
        list.removeAt(_index);
      }
    }
    attListSize();
  }

  @action
  void attListSize() {
    double _cartPrice = 0.0;
    int _listSize = 0;

    list.forEach((element) {
      _listSize += element.quantity;
      _cartPrice += element.quantity * element.product.price;
    });

    listLength = _listSize.toString();
    cartPrice = _cartPrice.reais();
  }
}