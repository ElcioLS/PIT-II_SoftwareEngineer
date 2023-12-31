import 'package:cupcakesbr/app/core/ui/formatter_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/ui/widgets/cupcakesbr_appbar.dart';
import '../../../models/order_pix.dart';

class PixPage extends StatelessWidget {
  final OrderPix _orderPix = Get.arguments;

  PixPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var qrCode = Uri.parse(_orderPix.image).data;

    return Scaffold(
        appBar: CupcakesbrAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Valor a pagar',
                    style: context.textTheme.headlineMedium,
                  ),
                  Text(
                    FormatterHelper.formatCurrency(_orderPix.totalValue),
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: context.theme.primaryColorDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.memory(
                    qrCode!.contentAsBytes(),
                    width: context.widthTransformer(reducedBy: 50),
                    height: context.heightTransformer(reducedBy: 50),
                  ),
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: _orderPix.code,
                        ),
                      );
                      Get.rawSnackbar(
                        message: 'Código Pix copiado',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.grey),
                    child: Text(
                      'PIX copia e cola',
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontSize: 30,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
