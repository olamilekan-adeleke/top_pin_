import 'package:riverpod/all.dart';

import '../../auth/methods/auth_methods.dart';
import '../../auth/model/register_user_model.dart';

final authProvider = Provider<Authentication>((ref) => Authentication());

//final logInProvider =
//    FutureProvider.autoDispose.family<bool, LoginUserModel>((ref, loginUser) {
//  final authService = ref.watch(authProvider);
//
//  return authService.logInUser(loginUser);
//});

final signUpProvider = FutureProvider.autoDispose
    .family<Map, RegisterUserModel>((ref, registerUser) {
  final authService = ref.watch(authProvider);

  return authService.signUpUser(registerUser);
});
