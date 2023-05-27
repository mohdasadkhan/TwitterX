import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterx/apis/auth_api.dart';
import 'package:twitterx/core/core.dart';

//stateNotifierProvider<returning type, state notifier state (which is bool in our case)>
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    return AuthController(authAPI: ref.watch(authAPIProvider));
  },
);

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);

  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;
    res.fold((l) => AppUtils.showSnackbar(context, l.message), (r) => null);
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;
    res.fold((l) => AppUtils.showSnackbar(context, l.message), (r) => null);
  }
}
