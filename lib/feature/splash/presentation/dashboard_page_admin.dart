import 'package:auto_route/auto_route.dart';
import 'package:digital_canteen/feature/authentication/presentation/provider/auth_provider.dart';
import 'package:digital_canteen/shared/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/routes/app_route.dart';
import '../../../shared/providers/firebase_providers.dart';

@RoutePage()
class DashboardPageAdmin extends HookConsumerWidget {
  const DashboardPageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authStateProvider);
    ref.listen(userStreamListenerProvider, (previous, next) {
      next.whenData((user) {
        if (user != null) {
          logger.e('User logged in: ${user.email}');
        } else {
          logger.e('User logged out');
          EasyLoading.showToast(
            "Logged out Successfully",
            dismissOnTap: true,
            maskType: EasyLoadingMaskType.black,
          );
          return context.router.pushAndPopUntil(
            const LoginRoute(),
            predicate: (route) => false,
          );
          // return context.router.pushAndPopUntil(
          //   const LoginRoute(),
          //   predicate: (route) => false,
          // );
        }
      });
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: Image.asset('assets/images/logo.png'),
        title: Text(
          'Digital Canteen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        actions: [
          const Text(
            'Hey Admin',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const SizedBox(width: 10),
          Image.asset('assets/images/waving.png', scale: 20),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () async {
              await ref.read(authStateProvider.notifier).signOut();
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              const SizedBox(height: 25),
              Text(
                'Today\'s Income',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'RS. 100',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  leading: Image.asset('assets/images/qrcodelogo.png'),
                  title: const Text('QR Scan'),
                  subtitle: const Text(
                    'Helps you to easily scan order with QR code',
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  leading: Image.asset('assets/images/view_order_logo.png'),
                  title: const Text('QR Scan'),
                  subtitle: const Text(
                    'Helps you to easily scan order with QR code',
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  leading: Image.asset('assets/images/add_food_logo.png'),
                  title: const Text('QR Scan'),
                  subtitle: const Text(
                    'Helps you to easily scan order with QR code',
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  leading: Image.asset('assets/images/add_user_logo.png'),
                  title: const Text('Add User'),
                  subtitle: const Text(
                    'Helps you to easily scan order with QR code',
                  ),
                  onTap: () => context.router.push(const RegisterRoute()),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  leading: Image.asset('assets/images/log_logo.png'),
                  title: const Text('Log'),
                  subtitle: const Text('Helps you to look for log of the day'),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  leading: Image.asset('assets/images/analysis_logo.png'),
                  title: const Text('Log'),
                  subtitle: const Text('Helps you to look for log of the day'),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  leading: Image.asset('assets/images/bestseller.png'),
                  title: const Text('Best Selling Food'),
                  subtitle: const Text('Helps you to look for log of the day'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
