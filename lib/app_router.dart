import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tutor_app/screens/info_screen.dart';
import 'package:tutor_app/screens/splash_screen.dart';

import 'main.dart';

class AppRouter {
  late final router = GoRouter(
    initialLocation: '/',
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(
            'Ошибка:\n${state.error}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const MyHomePage(title: '',),
        routes: [
          GoRoute(
              path: 'info',
              name: 'info',
              builder: (context, state) {
                final title = state.uri.queryParameters['text'] as String;
                return InfoScreen(text: title,);
              }
          ),
        ]
      ),
    ],
  );
}
