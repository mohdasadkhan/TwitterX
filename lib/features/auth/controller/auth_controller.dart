import 'package:appwrite/models.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterx/apis/auth_api.dart';
import 'package:twitterx/apis/user_api.dart';
import 'package:twitterx/core/core.dart';
import 'package:twitterx/features/auth/ui_view/login_view.dart';
import 'package:twitterx/features/home/screens/home_screen.dart';
import 'package:twitterx/models/model.dart';

//stateNotifierProvider<returning type, state notifier state (which is bool in our case)>
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    return AuthController(
        authAPI: ref.watch(authAPIProvider),
        userAPI: ref.watch(userAPIProvider));
  },
);

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  return ref.watch(authControllerProvider.notifier).currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);

  Future<model.User?> currentUser() => _authAPI.currentUserAccount();

  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;
    res.fold(
      (l) => AppUtils.showSnackbar(context, l.message),
      (r) async {
        UserModel userModel = UserModel(
          email: email,
          name: AppUtils.getNameFromEmail(email),
          followers: const [],
          following: const [],
          profilePic: '',
          bannerPic: '',
          uid: r.$id,
          bio: '',
          isTwitterBlue: false,
        );
        final res2 = await _userAPI.saveUserData(userModel);
        res2.fold((l) => AppUtils.showSnackbar(context, l.message), (r) {
          AppUtils.showSnackbar(
              context, 'Account Successfully created! Please Login');
          Navigator.of(context).push(Login.route());
        });
      },
    );
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;
    res.fold(
      (l) => AppUtils.showSnackbar(context, l.message),
      (r) {
        AppUtils.showSnackbar(context, 'Login Successfully');
        Navigator.of(context).push(HomeScreen.route());
      },
    );
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }
}
