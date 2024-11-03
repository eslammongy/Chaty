import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chaty/core/widgets/error_screen.dart';
import 'package:chaty/features/auth/cubit/auth_cubit.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/data/repo/chat_repo.dart';
import 'package:chaty/features/auth/data/repos/auth_repo.dart';
import 'package:chaty/features/user/data/repos/user_repo.dart';
import 'package:chaty/features/settings/data/settings_repo.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:chaty/features/settings/cubit/settings_cubit.dart';
import 'package:chaty/core/services/services_locator.dart' as injectable;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp().whenComplete(
    () async => await initAppConfiguration(),
  );
}

Future<void> initAppConfiguration() async {
  try {
    await Firebase.initializeApp();
    await injectable.initServices();
    await AppRouter.setInitialRoute();
    runApp(const Chatty());
  } catch (e) {
    FlutterNativeSplash.remove();
    runApp(ErrorScreen(error: e.toString()));
  } finally {
    FlutterNativeSplash.remove();
  }
}

class Chatty extends StatelessWidget {
  const Chatty({super.key});

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
              title: 'Chatty',
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
