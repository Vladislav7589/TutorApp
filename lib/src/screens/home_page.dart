import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/dio_provider.dart';



class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userId = ref.watch(idUserProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          userId != null ? IconButton(
            splashRadius: 1,
            icon: Icon(Icons.account_circle_outlined, size: 35, color: Colors.green),
            onPressed: () {
              context.goNamed("profile");
            },
          )
          : IconButton(
            splashRadius: 1,
            icon:  Icon(Icons.account_circle_outlined, size: 35, color: Colors.red),
            onPressed: () {
               context.goNamed("login");
            },
          ),
          ElevatedButton(
            onPressed: ()   async {
              final prefs = await SharedPreferences.getInstance();
              final accessToken = prefs.getString('accessToken') ?? '';
              final refreshToken = prefs.getString('refreshToken') ?? '';
              final id = prefs.getInt('id') ;
              print(accessToken);
              print(refreshToken);
              print(id);
              //prefs.remove("id");
              print(userId);
            },
            child: const Text(
              'Вывести',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
          toolbarHeight: 50,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Container(
          height: 50,
          child: Image.asset(
            "assets/logo_text.png",
            fit: BoxFit.fitHeight,
          ),
        )
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: Text('info'),
              onTap: () => context.goNamed('info', queryParameters: {'text': 'info'}),
            ),
/*            ListTile(
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
            ),*/
            // Добавьте больше ListTile для других страниц
          ],
        ).toList(),
      ),
    );
  }
}


