import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chaty/features/auth/data/repos/auth_repo.dart';
import 'package:chaty/features/users/data/repos/user_repo.dart';
import 'package:chaty/features/settings/data/settings_repo.dart';
import 'package:chaty/features/auth/data/repos/auth_repo_impl.dart';
import 'package:chaty/features/users/data/repos/user_repo_impl.dart';
import 'package:chaty/features/settings/data/settings_repo_impl.dart';

final getIt = GetIt.instance;
Future<void> initServices() async {
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImplementation(firebaseAuth: getIt()),
  );

  getIt.registerSingleton<UserRepo>(
    UserRepoImpl(firebaseAuth: getIt()),
  );

  getIt.registerSingleton<SettingsRepo>(
    SettingsRepoImpl(),
  );
}
