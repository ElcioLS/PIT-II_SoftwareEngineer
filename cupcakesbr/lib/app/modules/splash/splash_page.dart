import 'package:cupcakesbr/app/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/ui/widgets/cupcakesbr_button.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(80, 222, 62, 129),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.width * .85,
                height: 200,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 90, 1, 90),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .40,
                    height: MediaQuery.of(context).size.height * .30,
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 90, 1, 90),
                            border: const Border.fromBorderSide(
                                BorderSide(color: Colors.transparent)),
                            borderRadius: BorderRadius.circular(30)),
                        child: Image.asset('assets/images/cpkbr.png')),
                  ),
                  const SizedBox(height: 80),
                  CupcakesbrButton(
                    label: 'ACESSAR',
                    width: context.widthTransformer(reducedBy: 40),
                    height: 50,
                    onPressed: () => controller.checkLogged(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
