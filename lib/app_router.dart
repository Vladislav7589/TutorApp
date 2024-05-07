import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tutor_app/src/screens/calendar_page.dart';
import 'package:tutor_app/src/screens/home_page.dart';
import 'package:tutor_app/src/screens/buttom_sheet.dart';
import 'package:tutor_app/src/screens/login_page.dart';
import 'package:tutor_app/src/screens/navigation_page.dart';
import 'package:tutor_app/src/screens/profile_page.dart';
import 'package:tutor_app/src/screens/register_page.dart';
import 'package:tutor_app/src/screens/splash_page.dart';
import 'package:tutor_app/src/widgets/card_review.dart';


final GlobalKey<NavigatorState> rootNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter {
  late final router = GoRouter(
    navigatorKey: rootNavigatorKey,
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

    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return NavigationPage(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) =>  MyHomePage(),
              routes: [
                GoRoute(
                    path: 'login',
                    name: 'login',
                    builder: (context, state) => const LoginPage(),
                    routes: [
                      GoRoute(
                        path: 'register',
                        name: 'register',
                        builder: (context, state) =>  const RegisterPage(),
                      ),
                    ]
                ),
                GoRoute(
                  path: 'profile',
                  name: 'profile',
                  builder: (context, state) => const ProfilePage(),
                ),
              ]
          ),
          GoRoute(
            path: '/b',
            builder: (context, state) => const CalendarPage(),
          ),
          GoRoute(
            path: '/c',
            builder: (BuildContext context, GoRouterState state) {
              return const ScreenC();
            }
          ),

        ],
      ),
    ],
  );
}


/// The third screen in the bottom navigation bar.
class ScreenC extends StatelessWidget {
  /// Constructs a [ScreenC] widget.
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Screen C'),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/c/details');
              },
              child: const Text('View C details'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The details screen for either the A, B or C screen.
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    super.key,
  });

  /// The label to display in the center of the screen.
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Center(
        child: Text(
          'Details for $label',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}