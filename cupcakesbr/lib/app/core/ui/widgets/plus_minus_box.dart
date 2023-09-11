import 'package:cupcakesbr/app/core/ui/formatter_helper.dart';
import 'package:flutter/material.dart';

import 'cupcakesbr_rounded_button.dart';

class PlusMinusBox extends StatelessWidget {
  final bool elevated;
  final Color? backgroundColor;
  final String? label;
  final int quantity;
  final double price;
  final VoidCallback minusCallBack;
  final VoidCallback plusCallBack;
  final bool calculateTotal;

  const PlusMinusBox({
    Key? key,
    required this.quantity,
    required this.price,
    required this.minusCallBack,
    required this.plusCallBack,
    this.elevated = false,
    this.backgroundColor,
    this.label,
    this.calculateTotal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevated ? 5 : 0,
      borderRadius: BorderRadius.circular(20),
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.259),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Visibility(
                visible: label != null,
                child: Text(
                  label ?? '',
                  style: const TextStyle(fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Row(
              children: [
                CupcakesbrRoundedButton(
                  onPressed: minusCallBack,
                  label: '-',
                ),
                Text('$quantity'),
                CupcakesbrRoundedButton(
                  onPressed: plusCallBack,
                  label: '+',
                ),
              ],
            ),
            Visibility(
              visible: label == null,
              child: const Spacer(),
            ),
            SingleChildScrollView(
              child: Expanded(
                child: Container(
                  constraints: const BoxConstraints(minWidth: 70),
                  child: Text(
                    FormatterHelper.formatCurrency(
                      calculateTotal ? price * quantity : price,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
