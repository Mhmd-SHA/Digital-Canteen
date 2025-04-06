import 'package:dartz/dartz.dart';
import 'package:digital_canteen/shared/exceptions/app_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/helpers/logger.dart';
import '../../../../shared/providers/firebase_providers.dart';
import 'firebase_firestore_data_source.dart';

final authDataSourceProvider = Provider((ref) {
  final firebaseAuth = ref.read(firebaseaAuthInstanceProvider);
  final firebaseFireStoreAuthDataSource =
      ref.read(fireStoreAuthDataSourceProvider);
  final firebaseFireStore = ref.read(firebaseFirestoreInstanceProvider);

  return AuthDataSource(
    firebaseAuth,
    firebaseFireStoreAuthDataSource,
    ref,
  );
});

class AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestoreDataSource firebaseFirestoreDataSource;
  final Ref _ref;

  AuthDataSource(
    this._firebaseAuth,
    this.firebaseFirestoreDataSource,
    this._ref,
  );

  Future<Either<AppException, User>> signup({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await response.user!.updateDisplayName(name);
      await firebaseFirestoreDataSource.createUser(response.user!.uid);
      return right(response.user!);
    } on FirebaseAuthException catch (e) {
      return left(AuthException.fromFirebaseAuth(e));
    } on FirebaseException catch (e) {
      return left(DatabaseException.fromFirestore(e));
    } catch (e) {
      logger.e(e.toString());
      return left(UnknownException(e));
    }
  }

  Future<Either<AppException, User>> login(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(response.user!);
    } on FirebaseAuthException catch (e) {
      return left(AuthException.fromFirebaseAuth(e));
    }
  }

  Future<Either<AppException, void>> logout() async {
    try {
      final response = await _firebaseAuth.signOut();
      return right(response);
    } on FirebaseAuthException catch (e) {
      return left(AuthException.fromFirebaseAuth(e));
    }
  }

  // Future<Either<String, User>> continueWithGoogle() async {
  //   try {
  //     final googleSignIn =
  //         GoogleSignIn(clientId: DefaultFirebaseOptions.ios.iosClientId);
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       final response = await _firebaseAuth.signInWithCredential(credential);
  //       return right(response.user!);
  //     } else {
  //       return left('Unknown Error');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     return left(e.message ?? 'Unknow Error');
  //   }
  // }
}

// final firebaseAuthInstanceProvider =
//     Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// final authDataSourceProvider = Provider<AuthDataSource>(
//   (ref) => AuthDataSource(ref.read(firebaseAuthInstanceProvider), ref),
// );


// @riverpod
// AuthDataSource authDataSource(AuthDataSourceRef ref) {
//   final firebaseInstance = ref.read(firebaseaAuthInstanceProvider);
//   return AuthDataSource(firebaseInstance, ref);
// }
