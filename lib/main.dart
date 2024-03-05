import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/firebase_options.dart';
import 'package:flutter_firebase/theme/theme_data.dart';
import 'package:flutter_firebase/utils/app_routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_firebase/utils/services_locator.dart' as injectable;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await injectable.initServices();
  await AppRouter.setInitialRoute();
  runApp(const FlutterFirebase());
  await Future.delayed(
      const Duration(microseconds: 1000), FlutterNativeSplash.remove);
}

class FlutterFirebase extends StatelessWidget {
  const FlutterFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (_, orientation, deviceType) {
      return MaterialApp.router(
        title: 'FoxTracker',
        debugShowCheckedModeBanner: false,
        theme: getDarkThemeData(),
        routerConfig: AppRouter.appRoutes(),
      );
    });
  }
}
