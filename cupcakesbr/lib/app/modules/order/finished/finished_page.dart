import 'package:cupcakesbr/app/models/order_pix.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/ui/widgets/cupcakesbr_button.dart';

class FinishedPage extends StatelessWidget {
  final OrderPix _orderPix = Get.arguments;

  FinishedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                Image.asset(
                  'assets/images/logo_rounded.png',
                  width: context.widthTransformer(reducedBy: 50),
                  height: context.heightTransformer(reducedBy: 70),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Pedido realizado com sucesso, clique no botão abaixo para acesso ao QRCode de PIX',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge?.copyWith(
                        color: context.theme.primaryColorDark,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: context.widthTransformer(reducedBy: 30),
                  child: CupcakesbrButton(
                    label: 'PIX',
                    onPressed: () {
                      Get.toNamed('/order/pix', arguments: _orderPix);
                    },
                    color: context.theme.primaryColorDark,
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: context.widthTransformer(reducedBy: 10),
                  child: CupcakesbrButton(
                    label: 'FECHAR',
                    onPressed: () {
                      Get.offAllNamed('/home');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
