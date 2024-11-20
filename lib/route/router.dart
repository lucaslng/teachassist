import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teachassist/route/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => const RouteType.material();

 @override
 List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true, maintainState: true),
    AutoRoute(page: LoginRoute.page, maintainState: false, keepHistory: false),
    AutoRoute(page: ScraperSplash.page, maintainState: false, keepHistory: false),
    AutoRoute(page: HomeRoute.page, maintainState: true, keepHistory: true),
    // CustomRoute(page: CourseRoute.page, keepHistory: true, transitionsBuilder: TransitionsBuilders.slideLeft, durationInMilliseconds: Durations.long1.inMilliseconds, reverseDurationInMilliseconds: Durations.long1.inMilliseconds),
    AutoRoute(page: CourseRoute.page),
    AutoRoute(page: ErrorRoute.page, maintainState: false)
 ];
}