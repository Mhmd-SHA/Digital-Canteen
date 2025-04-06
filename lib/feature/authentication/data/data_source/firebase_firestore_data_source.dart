// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:digital_canteen/shared/exceptions/app_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/constants/firebase_firestore_collection_keys.dart';
import '../../../../shared/providers/firebase_providers.dart';

final fireStoreAuthDataSourceProvider = Provider((ref) {
  final firebaseFireStore = ref.read(firebaseFirestoreInstanceProvider);

  return FirebaseFirestoreDataSource(firebaseFirestore: firebaseFireStore);
});

class FirebaseFirestoreDataSource {
  final FirebaseFirestore firebaseFirestore;
  const FirebaseFirestoreDataSource({
    required this.firebaseFirestore,
  });

  Future<Either<AppException, void>> createUser(String generatedDocId) async {
    try {
      DocumentReference docRef = firebaseFirestore
          .collection(FirebaseFirestoreCollectionKeys.users)
          .doc(generatedDocId);

      final res = await docRef.set({
        "userId": generatedDocId,
        "userName": "MhmdSHA",
      });

      return Right(res);
    } on FirebaseException catch (e) {
      return Left(DatabaseException.fromFirestore(e));
    } catch (e) {
      return left(UnknownException(e));
    }
  }
}
