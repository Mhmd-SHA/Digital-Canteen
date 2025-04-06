import 'package:digital_canteen/firebase_options.dart';
import 'package:digital_canteen/main/my_app.dart';
import 'package:digital_canteen/main/observers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(observers: [Observers()], child: MyApp()));
}
