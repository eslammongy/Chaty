import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase/core/theme/theme_data.dart';
import 'package:flutter_firebase/core/utils/app_routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_firebase/features/signin/cubit/signin_cubit.dart';
import 'package:flutter_firebase/features/signin/data/repos/signin_repo.dart';
import 'package:flutter_firebase/core/utils/services_locator.dart' as injectable;
import 'package:flutter_firebase/features/profile/cubit/profile_info_cubit.dart';
import 'package:flutter_firebase/features/profile/data/repos/profile_info_repo.dart';
    

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await injectable.initServices();
  await AppRouter.setInitialRoute();
  runApp(const FlutterFirebase());
  Future.delayed(
      const Duration(microseconds: 1000), FlutterNativeSplash.remove);
}

class FlutterFirebase extends StatelessWidget {
  const FlutterFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignInCubit(
              signInRepo: injectable.getIt<SignInRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileInfoCubit(
              profileInfoRepo: injectable.getIt<ProfileInfoRepo>(),
            ),
          )
        ],
        child: MaterialApp.router(
          title: 'Flutter Firebase',
          debugShowCheckedModeBanner: false,
          theme: getDarkThemeData(),
          routerConfig: AppRouter.appRoutes(),
        ),
      ),
    );
  }
}
