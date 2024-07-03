import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:chaty/features/auth/cubit/auth_cubit.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/users/cubit/user_cubit.dart';
import 'package:chaty/features/chats/data/repo/chat_repo.dart';
import 'package:chaty/features/auth/data/repos/auth_repo.dart';
import 'package:chaty/features/users/data/repos/user_repo.dart';
import 'package:chaty/features/settings/data/settings_repo.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:chaty/features/settings/cubit/settings_cubit.dart';
import 'package:chaty/core/utils/services_locator.dart' as injectable;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await _setupAppConfiguration(widgetsBinding);
}

Future<void> _setupAppConfiguration(WidgetsBinding widgetsBinding) async {
  Future.delayed(const Duration(microseconds: 1000), () async {
    await Firebase.initializeApp();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await injectable.initServices();
    await AppRouter.setInitialRoute();
    runApp(const Chaty());
    FlutterNativeSplash.remove();
  });
}

class Chaty extends StatelessWidget {
  const Chaty({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              authRepo: injectable.getIt<AuthRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserCubit(
              userRepo: injectable.getIt<UserRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => SettingsCubit(
              settingsRepo: injectable.getIt<SettingsRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => ChatCubit(
              chatRepo: injectable.getIt<ChatRepo>(),
            ),
          )
        ],
        child: BlocBuilder<SettingsCubit, SettingsStates>(
          builder: (context, state) {
            final currentTheme = SettingsCubit.get(context).currentTheme;
            return MaterialApp.router(
              title: 'Chaty',
              debugShowCheckedModeBanner: false,
              theme: currentTheme,
              routerConfig: AppRouter.appRoutes(),
            );
          },
        ),
      ),
    );
  }
}
