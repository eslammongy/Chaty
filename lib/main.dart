import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chaty/core/theme/theme_data.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/features/signin/cubit/signin_cubit.dart';
import 'package:chaty/features/users/data/repos/user_repo.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:chaty/features/signin/data/repos/signin_repo.dart';
import 'package:chaty/core/utils/services_locator.dart' as injectable;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await injectable.initServices();
  await AppRouter.setInitialRoute();
  runApp(const Chaty());
  Future.delayed(
      const Duration(microseconds: 1000), FlutterNativeSplash.remove);
}

class Chaty extends StatelessWidget {//arch -x86_64 pod install
  const Chaty({super.key});

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
            create: (context) => UserCubit(
              userRepo: injectable.getIt<UserRepo>(),
            ),
          )
        ],
        child: MaterialApp.router(
          title: 'Chaty',
          debugShowCheckedModeBanner: false,
          theme: getDarkThemeData(),
          routerConfig: AppRouter.appRoutes(),
        ),
      ),
    );
  }
}
