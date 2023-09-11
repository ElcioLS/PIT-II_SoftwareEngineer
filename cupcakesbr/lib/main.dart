import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/core/bindings/application_binding.dart';
import 'app/core/ui/cupcakesbr_ui.dart';
import 'app/routes/auth_routers.dart';
import 'app/routes/home_routers.dart';
import 'app/routes/orders_routers.dart';
import 'app/routes/product_routers.dart';
import 'app/routes/splash_routers.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const CupcakesbrMainApp());
}

class CupcakesbrMainApp extends StatelessWidget {
  const CupcakesbrMainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cupcakes BR',
      theme: CupcakesbrUI.theme,
      initialBinding: ApplicationBinding(),
      getPages: [
        ...SplashRouters.routers,
        ...AuthRouters.routers,
        ...HomeRouters.routers,
        ...ProductRouters.routers,
        ...OrdersRouters.routers,
      ],
    );
  }
}
