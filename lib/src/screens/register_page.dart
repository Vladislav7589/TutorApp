import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

import '../widgets/text_field_widget.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTokens(String refreshToken, String accessToken) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('refreshToken', refreshToken);
  await prefs.setString('accessToken', accessToken);
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    'Регистрация',
                    style: TextStyle(
                      color: Color(0xDF290505),
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Необходимо зарегистрироваться',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Center(
                child: Icon(
                  Icons.account_circle,
                  size: MediaQuery.of(context).size.width * 0.55,
                  color: Colors.black26,
                ),
              ),
              TextFieldWidget(
                controller: usernameController,
                labelText: 'Имя',
                keyboardType: TextInputType.text,
              ),
              TextFieldWidget(
                controller: emailController,
                labelText: 'E-mail',
                keyboardType: TextInputType.emailAddress,
              ),
              // TextFieldWidget(
              //   controller: numberController,
              //   labelText: 'Номер телефона',
              //   keyboardType: TextInputType.phone,
              // ),
              TextFieldWidget(
                controller: passwordController,
                labelText: 'Пароль',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              // TextFieldWidget(
              //   controller: secondPasswordController,
              //   labelText: 'Повторите пароль',
              //   obscureText: true,
              //   keyboardType: TextInputType.visiblePassword,
              // ),
              ElevatedButton(
                onPressed: () async {

                  final Map<String, dynamic> userData = {
                    'username': usernameController.text,
                    'email': emailController.text,
                    'password': passwordController.text,
                    'is_superuser': false, // не является суперпользователем
                    'is_staff': false, // не является персоналом
                    'is_active': true,// Значение должно быть логическим (true/false), не строкой
                  };
                  register(userData);
                  context.goNamed('profile');
                },
                child: const Text(
                  'Зарегистрироваться',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField(
      String hitName, TextEditingController textEditingControl, int maxLine) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 8),
      child: TextField(
        maxLines: maxLine,
        controller: textEditingControl,
        decoration: InputDecoration(
          hoverColor: Colors.black,
          focusColor: Colors.black,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelText: hitName,
          labelStyle: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}


Future<void> register(Map<String, dynamic> userData) async {
  final String apiUrl = 'http://0.0.0.0:8000/api/register/';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json', // Указываем тип медиа как JSON
    },
    body: json.encode(userData), // Кодируем данные в формат JSON
  );


  if (response.statusCode == 200) {
    // Успешно зарегистрирован
    print('User registered successfully \n Ответ: ${response.body}');

    // Получаем данные ответа
    final responseData = json.decode(response.body);

    // Сохраняем токены в SharedPreferences
    await saveTokens(responseData['refresh'], responseData['access']);

  } else {
    // Не удалось зарегистрироваться, обработайте ошибку
    print('Failed to register user: ${response.body}');
  }
}