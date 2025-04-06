import 'package:dartz/dartz.dart';
import 'package:digital_canteen/feature/authentication/data/data_source/firebase_auth_data_source.dart';
import 'package:digital_canteen/feature/authentication/data/repository/auth_repository_impl.dart';
import 'package:digital_canteen/shared/exceptions/app_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(authDataSourceProvider);

  return AuthRepositoryImpl(authDataSource: dataSource);
});

abstract class AuthRepositoy {
  Future<Either<AppException, User>> signIn(
      {required String email, required String password});
  Future<Either<AppException, User>> registerUser({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
  });
  Future<Either<AppException, void>> signOut();
}

// Assuming AuthRepository is implemented somewhere
// final authRepositoryProvider = Provider<AuthRepository>((ref) {
//   // Return an instance of your AuthRepository implementation here
//   return AuthRepositoryImpl(); // Replace AuthRepositoryImpl with your concrete class
// });

