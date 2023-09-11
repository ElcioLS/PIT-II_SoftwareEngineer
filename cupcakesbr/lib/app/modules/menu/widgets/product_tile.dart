import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/ui/cupcakesbr_ui.dart';
import '../../../core/ui/formatter_helper.dart';
import '../../../models/product_model.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;

  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/product_detail', arguments: product);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 80,
        child: Row(
          children: [
            Container(
              width: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                    image: NetworkImage(
                      'http://192.168.0.5:8080/images${product.image}',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                //coloquei esse  SingleChildScrollView pra parar que quebrar
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      product.name,
                      style: CupcakesbrUI.textBold,
                    ),
                    // Text('R\$ ${product.price}'),
                    Text(FormatterHelper.formatCurrency(product.price)),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
