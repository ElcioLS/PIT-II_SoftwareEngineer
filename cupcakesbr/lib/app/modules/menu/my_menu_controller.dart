import 'dart:developer';

import 'package:cupcakesbr/app/core/mixins/loader_mixin.dart';
import 'package:cupcakesbr/app/core/mixins/messages_mixin.dart';
import 'package:cupcakesbr/app/models/product_model.dart';
import 'package:get/get.dart';

import '../../repositories/auth/products/product_repository.dart';

class MyMenuController extends GetxController with LoaderMixin, MessagesMixin {
  final ProductRepository _productRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();
  final menu = <ProductModel>[].obs;

  MyMenuController({required ProductRepository productRepository})
      : _productRepository = productRepository;

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    try {
      _loading.toggle();
      await findAllProducts();
      _loading.toggle();
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      _message(MessageModel(
          title: 'Erro',
          message: 'Erro ao buscar produtos',
          type: MessageType.error));
    }
  }

  Future<void> findAllProducts() async {
    final products = await _productRepository.findAll();
    menu.assignAll(products);
  }

  Future<void> refreshPage() async {
    super.onReady();
    try {
      await findAllProducts();
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      _message(MessageModel(
          title: 'Erro',
          message: 'Erro ao buscar produtos',
          type: MessageType.error));
    }
  }
}
