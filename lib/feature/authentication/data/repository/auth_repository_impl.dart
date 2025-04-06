import 'package:dartz/dartz.dart';
import 'package:digital_canteen/feature/authentication/data/data_source/firebase_auth_data_source.dart';
import 'package:digital_canteen/feature/authentication/domain/repositoy/auth_repository.dart';
import 'package:digital_canteen/shared/exceptions/app_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepositoy {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({
    required this.authDataSource,
  });
  @override
  Future<Either<AppException, User>> signIn(
      {required String email, required String password}) async {
    final result = await authDataSource.login(email: email, password: password);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<AppException, void>> signOut() async {
    final result = await authDataSource.logout();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<AppException, User>> registerUser({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
  }) async {
    final result = await authDataSource.signup(
        name: userName,
        email: email,
        password: password,
        phoneNumber: phoneNumber);
    return result.fold(
      (exception) => Left(exception),
      (user) => Right(user),
    );
  }
}
