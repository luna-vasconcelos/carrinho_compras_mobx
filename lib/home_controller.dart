import 'package:carrinho_compras/utils/extensions.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'models/product_model.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  String errorMessage = "";
  int numero = 0;

  @observable
  AppStatus appStatus = AppStatus.empty;

  List<Product> products = <Product>[];

  @action
  Future<void> getProducts() async {
    try {
      appStatus = AppStatus.loading;

      products = await Future.delayed(Duration(seconds: 2)).then(
        (value) => List.generate(
          50,
          (index) => Product(
            name: "Produto",
            image: "https://picsum.photos/10" +
                index.toString() +
                "/10" +
                index.toString(),
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            price: 1.0 * index,
          ),
        ),
      );

      appStatus = products.isNotEmpty ? AppStatus.success : AppStatus.empty;
    } on PlatformException catch (e) {
      errorMessage = e.message.toString();
      appStatus = AppStatus.error;
    } catch (e) {
      errorMessage = e.toString();
      appStatus = AppStatus.error;
      appStatus.message();
    }
  }
}
