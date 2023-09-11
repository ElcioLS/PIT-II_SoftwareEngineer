import 'package:cupcakesbr/app/core/ui/formatter_helper.dart';
import 'package:cupcakesbr/app/core/ui/widgets/plus_minus_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import './shopping_cart_controller.dart';
import '../../../core/ui/widgets/cupcakesbr_button.dart';

class ShoppingCartPage extends GetView<ShoppingCartController> {
  final formKey = GlobalKey<FormState>();

  ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: Form(
                  key: formKey,
                  child: Visibility(
                    visible: controller.products.isNotEmpty,
                    replacement: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Carrinho',
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.theme.primaryColorDark,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Seu carrinho está vazio!'),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Text(
                                'Carrinho',
                                style: context.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.theme.primaryColorDark,
                                ),
                              ),
                              IconButton(
                                onPressed: controller.clear,
                                icon: const Icon(
                                  Icons.delete_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          return Column(
                            children: controller.products
                                .map(
                                  (p) => Container(
                                    margin: const EdgeInsets.all(10),
                                    child: PlusMinusBox(
                                      label: p.product.name,
                                      calculateTotal: true,
                                      elevated: true,
                                      backgroundColor: Colors.white,
                                      quantity: p.quantity,
                                      price: p.product.price,
                                      minusCallBack: () {
                                        controller.subtractQuantityProduct(p);
                                      },
                                      plusCallBack: () {
                                        controller.addQuantityInProduct(p);
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        }),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total do pedido',
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Obx(
                                () {
                                  return Text(
                                    FormatterHelper.formatCurrency(
                                        controller.totalValue),
                                    style:
                                        context.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        const _AddressField(),
                        const Divider(),
                        const _CpfField(),
                        const Divider(),
                        const Spacer(),
                        Center(
                          child: SizedBox(
                            width: context.widthTransformer(reducedBy: 10),
                            child: CupcakesbrButton(
                              label: 'FINALIZAR',
                              onPressed: () {
                                final formValid =
                                    formKey.currentState?.validate() ?? false;
                                if (formValid) {
                                  controller.createOrder();
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AddressField extends GetView<ShoppingCartController> {
  const _AddressField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
            child: Expanded(
              child: Text(
                'Nome de quem retira',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              controller.address = value;
            },
            validator: Validatorless.required('Endereço obrigatório'),
            decoration: const InputDecoration(
              hintText: 'Digite o endereço',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _CpfField extends GetView<ShoppingCartController> {
  const _CpfField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
            child: Expanded(
              child: Text(
                'CPF',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              controller.cpf = value;
            },
            validator: Validatorless.multiple([
              Validatorless.required('CPF obrigatório'),
              Validatorless.cpf('CPF Inválido'),
            ]),
            decoration: const InputDecoration(
              hintText: 'Digite o CPF',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
