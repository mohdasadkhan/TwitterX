//abstract class will contains all the functions related to api
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:twitterx/core/core.dart';
import 'package:twitterx/core/providers.dart';

//provider lets us provider the instance of AuthAPI class which is immutable
final authAPIProvider = Provider((ref) {
  return AuthAPI(account: ref.watch(appwriteAccountProvider));
});

//want to signup, want to get user account >> Account service
//want to access user related data >> Account model

abstract class IAuthApi {
  //Either<Failure, Success>

  //whenever the signup we get the user account
  FutureEither<model.User> signUp(
      {required String email, required String password});

  //whenever we logIn we get the session
  FutureEither<model.Session> login(
      {required String email, required String password});

  Future<model.User?> currentUserAccount();
}

class AuthAPI extends IAuthApi {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  Future<model.User?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<model.User> signUp(
      {required String email, required String password}) async {
    try {
      final accountR = await _account.create(
          userId: ID.unique(), email: email, password: password);
      return right(accountR);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? 'Some unexpected error occured', stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Session> login(
      {required String email, required String password}) async {
    try {
      final session =
          await _account.createEmailSession(email: email, password: password);
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? 'Some unexpected error occured', stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
