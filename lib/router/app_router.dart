import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/home_view.dart';
import '../views/detail_view.dart';

/// Application routes
class AppRoutes {
  static const String home = '/';
  static const String detail = '/detail';
}

/// GoRouter configuration
final goRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.detail,
      name: 'detail',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const DetailView(),
      ),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri.path}'),
    ),
  ),
);
