import 'package:auto_route/auto_route.dart';
import 'package:teachassist/route/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => const RouteType.material();

 @override
 List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true, maintainState: true),
    AutoRoute(page: LoginRoute.page, maintainState: false, keepHistory: false),
    AutoRoute(page: ScraperSplash.page, maintainState: true, keepHistory: true),
    AutoRoute(page: HomeRoute.page, maintainState: false, keepHistory: false),
    AutoRoute(page: CourseRoute.page, maintainState: false),
    AutoRoute(page: ErrorRoute.page, maintainState: false)
 ];
}