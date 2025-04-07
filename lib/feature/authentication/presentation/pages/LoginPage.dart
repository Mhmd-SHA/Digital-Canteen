import 'package:auto_route/auto_route.dart';
import 'package:digital_canteen/feature/authentication/presentation/provider/auth_provider.dart';
import 'package:digital_canteen/feature/authentication/presentation/provider/auth_state.dart';
import 'package:digital_canteen/feature/splash/presentation/dashboard_page_admin.dart';
import 'package:digital_canteen/shared/components/widgets/app_button.dart';
import 'package:digital_canteen/shared/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Row(
              //   children: [
              //     Icon(Icons.fastfood),
              //     Expanded(
              //       child: Divider(
              //         height: 10,
              //         thickness: 5,
              //         color: Theme.of(context).primaryColor,
              //       ),
              //     ),
              //   ],
              // ),
              Text(
                "Log in to your Account",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              25.verticalSpace,
              TextFormField(
                controller: mailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25).r,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25).r,
                  hintText: 'Email',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              20.verticalSpace,
              TextFormField(
                controller: passController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  hintText: 'Password',
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              5.verticalSpace,
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'forgot password ?',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              25.verticalSpace,
              AppButton(
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
                buttonText: "Login",
                isLoading: authState.concreteState == AuthStateConcrete.loading,
              ),
              200.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
