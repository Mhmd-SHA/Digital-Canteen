import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseaAuthInstanceProvider = Provider((ref) => FirebaseAuth.instance);
final userProvider = Provider(
  (ref) {
    return ref.read(firebaseaAuthInstanceProvider).currentUser;
  },
);

final firebaseFirestoreInstanceProvider =
    Provider((ref) => FirebaseFirestore.instance);

final userStreamListenerProvider = StreamProvider(
  (ref) => ref.read(firebaseaAuthInstanceProvider).userChanges(),
);
