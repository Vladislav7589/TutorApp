import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


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
              title: Text('Авторизация'),
              onTap: () => context.goNamed('login'),
            ),
            ListTile(
              title: Text('Регистрация'),
              onTap: () => context.goNamed('register'),
            ),
            ListTile(
              title: Text('Профиль'),
              onTap: () => context.goNamed('profile'),
            ),
            // Добавьте больше ListTile для других страниц
          ],
        ).toList(),
      ),
    );
  }
}


