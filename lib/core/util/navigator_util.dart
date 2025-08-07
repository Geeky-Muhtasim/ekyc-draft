// ignore_for_file: unnecessary_await_in_return

import 'package:flutter/material.dart';

class NavigatorUtil {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState? get _navigator => navigatorKey.currentState;

  /// Push a new named route asynchronously.
  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    if (_navigator == null) return null;
    return await _navigator!.pushNamed<T>(routeName, arguments: arguments);
  }

  /// Pop the current route if possible.
  static void goBack<T extends Object?>([T? result]) {
    if (_navigator?.canPop() ?? false) {
      _navigator!.pop(result);
    }
  }

  /// Push and remove all routes until predicate returns true.
  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    required RoutePredicate predicate,
    Object? arguments,
  }) async {
    if (_navigator == null) return null;
    return await _navigator!.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  /// Push a new route and pop the current one.
  static Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) async {
    if (_navigator == null) return null;
    return await _navigator!.popAndPushNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  /// Replace current route with a new one.
  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) async {
    if (_navigator == null) return null;
    return await _navigator!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }
}
