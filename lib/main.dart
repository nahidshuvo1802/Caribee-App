import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:tutor_app/view/screens/splash/view/SplashScreens/SplashScreen.dart';

import 'package:tutor_app/controllers/network_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NetworkController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Caribee",
          defaultTransition: Transition.rightToLeftWithFade,
          transitionDuration: const Duration(milliseconds: 300),
          home: const SplashScreen(),
        );
      },
    );
  }
}
