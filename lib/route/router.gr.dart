// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i9;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i10;
import 'package:teachassist/pages/coursepage.dart' as _i1;
import 'package:teachassist/pages/errorpage.dart' as _i2;
import 'package:teachassist/pages/homepage.dart' as _i3;
import 'package:teachassist/pages/loginpage.dart' as _i4;
import 'package:teachassist/pages/scraper.dart' as _i5;
import 'package:teachassist/pages/splash.dart' as _i6;
import 'package:teachassist/utils/coursedata/course.dart' as _i8;

/// generated route for
/// [_i1.CoursePage]
class CourseRoute extends _i7.PageRouteInfo<CourseRouteArgs> {
  CourseRoute({
    required _i8.Course course,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          CourseRoute.name,
          args: CourseRouteArgs(course: course),
          initialChildren: children,
        );

  static const String name = 'CourseRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CourseRouteArgs>();
      return _i1.CoursePage(args.course);
    },
  );
}

class CourseRouteArgs {
  const CourseRouteArgs({required this.course});

  final _i8.Course course;

  @override
  String toString() {
    return 'CourseRouteArgs{course: $course}';
  }
}

/// generated route for
/// [_i2.ErrorPage]
class ErrorRoute extends _i7.PageRouteInfo<ErrorRouteArgs> {
  ErrorRoute({
    _i9.Key? key,
    required _i9.AsyncSnapshot<dynamic> snapshot,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          ErrorRoute.name,
          args: ErrorRouteArgs(
            key: key,
            snapshot: snapshot,
          ),
          initialChildren: children,
        );

  static const String name = 'ErrorRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ErrorRouteArgs>();
      return _i2.ErrorPage(
        key: args.key,
        snapshot: args.snapshot,
      );
    },
  );
}

class ErrorRouteArgs {
  const ErrorRouteArgs({
    this.key,
    required this.snapshot,
  });

  final _i9.Key? key;

  final _i9.AsyncSnapshot<dynamic> snapshot;

  @override
  String toString() {
    return 'ErrorRouteArgs{key: $key, snapshot: $snapshot}';
  }
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i7.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i9.Key? key,
    required List<_i8.Course> data,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>();
      return _i3.HomePage(
        key: args.key,
        data: args.data,
      );
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    required this.data,
  });

  final _i9.Key? key;

  final List<_i8.Course> data;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    required _i10.FlutterSecureStorage storage,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(storage: storage),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>();
      return _i4.LoginPage(args.storage);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({required this.storage});

  final _i10.FlutterSecureStorage storage;

  @override
  String toString() {
    return 'LoginRouteArgs{storage: $storage}';
  }
}

/// generated route for
/// [_i5.ScraperSplash]
class ScraperSplash extends _i7.PageRouteInfo<ScraperSplashArgs> {
  ScraperSplash({
    required String id,
    required String password,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          ScraperSplash.name,
          args: ScraperSplashArgs(
            id: id,
            password: password,
          ),
          initialChildren: children,
        );

  static const String name = 'ScraperSplash';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScraperSplashArgs>();
      return _i5.ScraperSplash(
        args.id,
        args.password,
      );
    },
  );
}

class ScraperSplashArgs {
  const ScraperSplashArgs({
    required this.id,
    required this.password,
  });

  final String id;

  final String password;

  @override
  String toString() {
    return 'ScraperSplashArgs{id: $id, password: $password}';
  }
}

/// generated route for
/// [_i6.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i6.SplashPage();
    },
  );
}
