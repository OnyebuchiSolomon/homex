import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/enum.dart';
import 'custom_routes.dart';

class AppNavigator {
  AppNavigator._();

  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static BuildContext get currentContext =>
      navigatorKey.currentContext!;

  static NavigatorState get navigator =>
      navigatorKey.currentState!;

  // ============================================================
  // PUSH
  // ============================================================

  static Future<T?> pushAndStackPage<T>(
      Widget page, {
        RouteStyle style = RouteStyle.material,
      }) {
    return navigator.push<T>(
      _getRoute(
        page,
        style: style,
      ),
    );
  }

  // ============================================================
  // REPLACE CURRENT PAGE
  // ============================================================

  static Future<T?> pushAndReplacePage<T, TO>(
      Widget page, {
        RouteStyle style = RouteStyle.material,
        TO? result,
      }) {
    return navigator.pushReplacement<T, TO>(
      _getRoute(
        page,
        style: style,
      ),
      result: result,
    );
  }

  // ============================================================
  // REMOVE ALL PREVIOUS PAGES
  // ============================================================

  static Future<T?> pushAndRemovePageUntil<T>(
      Widget page, {
        RouteStyle style = RouteStyle.material,
      }) {
    return navigator.pushAndRemoveUntil<T>(
      _getRoute(
        page,
        style: style,
      ),
          (route) => false,
    );
  }

  // ============================================================
  // NAMED ROUTES
  // ============================================================

  static Future<T?> pushAndStackNamed<T>(
      String routeName, {
        Object? arguments,
      }) {
    return navigator.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushAndReplaceNamed<T, TO>(
      String routeName, {
        Object? arguments,
        TO? result,
      }) {
    return navigator.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T>(
      String routeName, {
        Object? arguments,
      }) {
    return navigator.pushNamedAndRemoveUntil<T>(
      routeName,
          (route) => false,
      arguments: arguments,
    );
  }

  // ============================================================
  // POP
  // ============================================================

  static void pop<T>([T? result]) {
    if (navigator.canPop()) {
      navigator.pop<T>(result);
    }
  }

  static Future<bool> maybePop<T>([T? result]) {
    return navigator.maybePop<T>(result);
  }

  static void popUntil(
      RoutePredicate predicate,
      ) {
    navigator.popUntil(predicate);
  }

  // ============================================================
  // ROUTE BUILDER
  // ============================================================

  static Route<T> _getRoute<T>(
      Widget page, {
        required RouteStyle style,
      }) {
    switch (style) {
      case RouteStyle.material:
        return MaterialPageRoute<T>(
          builder: (_) => page,
        );

      case RouteStyle.cupertino:
        return CupertinoPageRoute<T>(
          builder: (_) => page,
        );

      case RouteStyle.fadeIn:
        return CustomRoutes.fadeIn<T>(page);

      case RouteStyle.slideIn:
        return CustomRoutes.slideIn<T>(page);

      case RouteStyle.slideUp:
        return CustomRoutes.slideUp<T>(page);
    }
  }
}

