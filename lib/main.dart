import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

final router = AppRouter().router;
final navigatorKey = GlobalKey<NavigatorState>();
final scaffoldKey = GlobalKey<ScaffoldMessengerState>();


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        scaffoldMessengerKey: scaffoldKey,
        debugShowCheckedModeBanner: false,
        title: 'TutorApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: router);
  }
}