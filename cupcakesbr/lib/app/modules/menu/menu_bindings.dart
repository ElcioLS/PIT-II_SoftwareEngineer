import 'package:cupcakesbr/app/repositories/auth/products/product_repository.dart';
import 'package:get/get.dart';

import '../../repositories/auth/products/product_repository_impl.dart';
import 'my_menu_controller.dart';

class MenuBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRepository>(
        () => ProductRepositoryImpl(restClient: Get.find()));

    Get.put(MyMenuController(productRepository: Get.find()));
  }
}
