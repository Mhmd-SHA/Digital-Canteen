import 'package:auto_route/auto_route.dart';
import 'package:digital_canteen/feature/authentication/presentation/provider/auth_provider.dart';
import 'package:digital_canteen/feature/authentication/presentation/provider/auth_state.dart';
import 'package:digital_canteen/feature/splash/presentation/dashboard_page_admin.dart';
import 'package:digital_canteen/shared/helpers/logger.dart';
import 'package:digital_canteen/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/routes/app_route.dart';

@RoutePage()
class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authNotifier = ref.watch(authStateProvider.notifier);
    final mailController = useTextEditingController();
    final passController = useTextEditingController();
    useEffect(() {
      mailController.text = "test@gmail.com";
      passController.text = "123456";
      return null;
    }, []);

    ref.listen(authStateProvider, (previous, current) async {
      if (previous != current) {
        if (current.concreteState == AuthStateConcrete.loading) {
          EasyLoading.showInfo("Loading...");
        }
        if (current.concreteState == AuthStateConcrete.error) {
          EasyLoading.showError(
            current.exception!.message,
            dismissOnTap: true,
            maskType: EasyLoadingMaskType.black,
          );
        }
        if (current.concreteState == AuthStateConcrete.loggedIn) {
          EasyLoading.showSuccess(
            "User Logged in Successfully\n${current.user?.displayName ?? ""}",
            dismissOnTap: true,
            maskType: EasyLoadingMaskType.black,
          );
          context.router.pushAndPopUntil(
            const DashboardRouteAdmin(),
            predicate: (route) => false,
          );
        }
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              width: 150,
              height: 150,
              "assets/images/logo.png",
              scale: 15,
            ),
            const SizedBox(height: 10),
            Text(
              'Digital Canteen',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: mailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusColor: Colors.greenAccent,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  hintText: 'Email',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.white),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: passController,
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusColor: Colors.greenAccent,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  hintText: 'Password',
                ),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.white),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'forgot password ?',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed:
                    authState.concreteState == AuthStateConcrete.loading
                        ? () {}
                        : () {
                          logger.d(mailController.text);
                          logger.d(passController.text);

                          ref
                              .read(authStateProvider.notifier)
                              .login(
                                email: mailController.text,
                                password: passController.text,
                              );
                        },
                child:
                    authState.concreteState == AuthStateConcrete.loading
                        ? const CircularProgressIndicator(
                          color: AppColors.black,
                        )
                        : const Text(
                          'Login',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),

                // child: AuthProvider.stream
                //   ..when(
                //     initial: () => const Text(
                //       'Login',
                //       style: TextStyle(fontSize: 25, color: Colors.white),
                //     ),
                //     loading: () => CircularProgressIndicator(
                //       color: AppColors.black,
                //     ),
                //     unauthenticated: (exception) => Text(
                //       'Login',
                //       style: TextStyle(fontSize: 25, color: Colors.white),
                //     ),
                //     authenticated: (user) => const Text(
                //       'Login',
                //       style: TextStyle(fontSize: 25, color: Colors.white),
                //     ),
                //   ),
              ),
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
