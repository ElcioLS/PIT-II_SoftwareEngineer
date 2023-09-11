import 'product_model.dart';

class ShoppingCartModel {
  int quantity;
  ProductModel product;

  ShoppingCartModel({
    required this.quantity,
    required this.product,
  });
}
