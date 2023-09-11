import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './product_detail_controller.dart';
import '../../core/ui/cupcakesbr_ui.dart';
import '../../core/ui/formatter_helper.dart';
import '../../core/ui/widgets/cupcakesbr_appbar.dart';
import '../../core/ui/widgets/cupcakesbr_button.dart';
import '../../core/ui/widgets/plus_minus_box.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupcakesbrAppBar(),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: context.width,
                        height: context.heightTransformer(reducedBy: 60),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'http://192.168.0.5:8080/images${controller.product.image}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          controller.product.name,
                          style: context.textTheme.headlineMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          controller.product.description,
                          style: context.textTheme.bodyMedium!,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () {
                          return PlusMinusBox(
                            minusCallBack: controller.removeProduct,
                            plusCallBack: controller.addProduct,
                            price: controller.product.price,
                            quantity: controller.quantity,
                          );
                        },
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text(
                          'Total',
                          style: CupcakesbrUI.textBold,
                        ),
                        trailing: Obx(
                          () {
                            return Text(
                              FormatterHelper.formatCurrency(
                                controller.totalPrice,
                              ),
                              style: CupcakesbrUI.textBold,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: SizedBox(
                          width: context.widthTransformer(reducedBy: 10),
                          child: CupcakesbrButton(
                            label: controller.alreadyAdded
                                ? 'Atualizar'
                                : 'ADICIONAR',
                            onPressed: controller.addProductInShoppingCart,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
