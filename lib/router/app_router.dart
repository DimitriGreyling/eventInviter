import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/home_view.dart';
import '../views/detail_view.dart';
import '../views/template_selection_view.dart';
import '../views/template_customization_view.dart';

/// Application routes
class AppRoutes {
  static const String home = '/';
  static const String detail = '/detail';
  static const String templates = '/templates';
  static String templateCustomize(String templateId) =>
      '/templates/$templateId/customize';
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
    GoRoute(
      path: AppRoutes.templates,
      name: 'templates',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const TemplateSelectionView(),
      ),
    ),
    GoRoute(
      path: '/templates/:templateId/customize',
      name: 'templateCustomize',
      pageBuilder: (context, state) {
        final templateId = state.pathParameters['templateId']!;
        return MaterialPage(
          key: state.pageKey,
          child: TemplateCustomizationView(templateId: templateId),
        );
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri.path}'),
    ),
  ),
);
