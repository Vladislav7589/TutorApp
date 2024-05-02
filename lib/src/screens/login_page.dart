
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_app/src/screens/profile_page.dart';
import 'package:tutor_app/src/screens/register_page.dart';

import '../widgets/text_field_widget.dart';
import 'package:http/http.dart' as http;


Future<void> authenticate(String email, String password) async {
  final String apiUrl = 'http://0.0.0.0:8000/api/login/';
  print(email);
  print(password);
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final accessToken = responseData['access'];
    final refreshToken = responseData['refresh'];
    // Сохраняем токены в SharedPreferences
    saveTokens(accessToken, refreshToken);
    print(response.body);
  } else {
    throw Exception('Failed to authenticate user: ${response.body}');
  }
}

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
        ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            final refreshToken = prefs.getString('refreshToken') ?? '';
            refreshTokens(refreshToken);
          },
          child: const Text(
            'обновить',
            style: TextStyle(color: Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            final accessToken = prefs.getString('accessToken') ?? '';
            print(accessToken);
                      },
          child: const Text(
            'вывести',
            style: TextStyle(color: Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: ()  {
            authenticate(emailController.text, passwordController.text);
          },
          child: const Text(
            'войти',
            style: TextStyle(color: Colors.red),
          ),
        ),
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


