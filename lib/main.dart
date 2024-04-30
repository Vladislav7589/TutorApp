import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';

void main() => runApp(const MyApp());

final router = AppRouter().router;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'TutorApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: router);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          "assets/logo_text.png",
          fit: BoxFit.contain,
        ),
        leadingWidth: 130,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: Text('info'),
              onTap: () => context.goNamed('info', queryParameters: {'text': 'info'}),
            ),
            ListTile(
              title: Text('Страница 2'),
              onTap: () => context.goNamed('details'),
            ),
            // Добавьте больше ListTile для других страниц
          ],
        ).toList(),
      ),
    );
  }
}


