import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chaty/features/signin/data/repos/signin_repo.dart';
import 'package:chaty/features/signin/data/repos/singin_repo_impl.dart';
import 'package:chaty/features/profile/data/repos/profile_info_repo.dart';
import 'package:chaty/features/profile/data/repos/profile_info_repo_impl.dart';

final getIt = GetIt.instance;
Future<void> initServices() async {
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  getIt.registerSingleton<SignInRepo>(
      SignInRepoImplementation(firebaseAuth: getIt()));

  getIt.registerSingleton<ProfileInfoRepo>(
      ProfileInfoRepoImpl(firebaseAuth: getIt()));
}
