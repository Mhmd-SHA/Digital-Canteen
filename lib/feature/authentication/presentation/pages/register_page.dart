import 'package:auto_route/auto_route.dart';
import 'package:digital_canteen/feature/authentication/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/helpers/logger.dart';
import '../provider/auth_state.dart';

@RoutePage()
class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authNotifier = ref.watch(authStateProvider.notifier);
    final mailController = useTextEditingController();
    final passController = useTextEditingController();
    final fullNameController = useTextEditingController();
    final phoneNumberController = useTextEditingController();
    useEffect(() {
      fullNameController.text = "fullName";
      phoneNumberController.text = "0123456789";
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
          // context.router.pushAndPopUntil(
          //   const DashboardRouteAdmin(),
          //   predicate: (route) => false,
          // );
        }
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            15.verticalSpace,
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
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            15.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusColor: Colors.greenAccent,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  hintText: 'Full Name',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            15.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusColor: Colors.greenAccent,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  hintText: 'Phone Number',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            25.verticalSpace,
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed:
                    authState.concreteState == AuthStateConcrete.loading
                        ? () {}
                        : () {
                          logger.d(
                            "${mailController.text} ${passController.text} ${fullNameController.text} ${phoneNumberController.text}",
                          );

                          ref
                              .read(authStateProvider.notifier)
                              .register(
                                phoneNumber: "",
                                userName: "",
                                email: mailController.text,
                                password: passController.text,
                              );
                        },
                child:
                    authState.concreteState == AuthStateConcrete.loading
                        ? const CircularProgressIndicator()
                        : Text(
                          'Register User',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
