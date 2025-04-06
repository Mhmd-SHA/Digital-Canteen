import 'package:auto_route/auto_route.dart';
import 'package:digital_canteen/feature/authentication/presentation/pages/LoginPage.dart';
import 'package:digital_canteen/feature/splash/presentation/dashboard_page_admin.dart';
import 'package:digital_canteen/feature/splash/presentation/splash_page.dart';

import '../../../feature/authentication/presentation/pages/register_page.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    // / routes go here
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: DashboardRouteAdmin.page),
  ];
}
