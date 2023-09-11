import 'package:cupcakesbr/app/repositories/order/order_repository.dart';
import 'package:cupcakesbr/app/repositories/order/order_repository_impl.dart';
import 'package:get/get.dart';

import './shopping_cart_controller.dart';

class ShoppingCartBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderRepository>(
        () => OrderRepositoryImpl(restClient: Get.find()));

    Get.put(ShoppingCartController(
      authService: Get.find(),
      shoppingCartService: Get.find(),
      orderRepository: Get.find(),
    ));
  }
}
