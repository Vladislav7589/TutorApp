
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_app/src/screens/profile_page.dart';
import 'package:tutor_app/src/screens/register_page.dart';

import '../providers/dio_provider.dart';
import '../widgets/text_field_widget.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();

  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    'Авторизация',
                    style: TextStyle(
                      color: Color(0xDF290505),
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildForm(context),
              _buildRegisterLink(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Icon(
            Icons.account_circle,
            size: MediaQuery.of(context).size.width * 0.55,
            color: Colors.black26,
          ),
        ),
        TextFieldWidget(
          controller: emailController,
          labelText: 'E-mail',
          keyboardType: TextInputType.emailAddress,
        ),
        TextFieldWidget(
          controller: passwordController,
          labelText: 'Пароль',
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),
        Consumer(
          builder: (_, WidgetRef ref, __) {
            return ElevatedButton(
              onPressed: ()   {
                final Map<String, dynamic> authData = {
                  'email': emailController.text,
                  'password': passwordController.text,
                };
                ref.watch(authenticateProvider(authData));
                ref.refresh(loadUserIdProvider);
                context.goNamed('profile');
              },
              child: const Text(
                'войти',
                style: TextStyle(color: Colors.red),
              ),
            );

          },
        ),
        ElevatedButton(
          onPressed: ()   async {
            final prefs = await SharedPreferences.getInstance();
            final accessToken = prefs.getString('accessToken') ?? '';
            final refreshToken = prefs.getString('refreshToken') ?? '';
            final id = prefs.getInt('id') ?? '';
            print(accessToken);
            print(refreshToken);
            print(id);
          },
          child: const Text(
            'Вывести',
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Нет учетной записи?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.justify,
          ),
        ),
        const Text("|"),
        TextButton(
          onPressed: () {
            context.goNamed('register');
          },
          child: const Text("Зарегистрироваться"),
        ),
      ],
    );
  }
}


