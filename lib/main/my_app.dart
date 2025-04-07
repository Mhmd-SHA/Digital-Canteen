import 'package:digital_canteen/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../shared/routes/app_route.dart';

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider);

    EasyLoading.init();
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: false,
      enableScaleText: () => false,
      useInheritedMediaQuery: false,
      enableScaleWH: () => false,
      builder:
          (context, child) => MaterialApp.router(
            title: 'Flutter TDD',
            // theme: AppTheme.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            // themeMode: themeMode,
            themeMode: ThemeMode.dark,
            routerConfig: appRouter.config(),
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(
              builder:
                  (context, child) => MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(textScaler: TextScaler.noScaling),
                    child: child!,
                  ),
            ),
          ),
    );
  }
}
