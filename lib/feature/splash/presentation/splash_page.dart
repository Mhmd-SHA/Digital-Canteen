import 'package:auto_route/auto_route.dart';
import 'package:digital_canteen/feature/authentication/presentation/pages/LoginPage.dart';
import 'package:digital_canteen/shared/constants/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/routes/app_route.dart';
import '../../../shared/providers/firebase_providers.dart';

@RoutePage()
class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 2), () {
        final user = ref.read(userProvider);
        if (user != null) {
          return context.router.pushAndPopUntil(
            const DashboardRouteAdmin(),
            predicate: (route) => false,
          );
        }
        return context.router.pushAndPopUntil(
          const LoginRoute(),
          predicate: (route) => false,
        );
      });
      return null;
    }, []);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset(ImageAssets.appLogo, height: 250, width: 250),
            25.verticalSpace,
            Text(
              'Digital Canteen',
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
