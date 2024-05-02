import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> fetchUserData(String token) async {
  final url = 'http://0.0.0.0:8000/api/users/'; // Замените на свой URL API
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token'
    },
  );
  print('Bearer $token');

  if (response.statusCode == 200) {
    // Если запрос успешен, парсим ответ в JSON и возвращаем данные пользователя
    return json.decode(response.body);
  } else {
    // Если произошла ошибка, выводим сообщение об ошибке
    throw Exception('Failed to load user data: ${response.body}');
  }
}
Future<Map<String, dynamic>> loadTokens() async {
  final prefs = await SharedPreferences.getInstance();
  final refreshToken = prefs.getString('refreshToken') ?? '';
  final accessToken = prefs.getString('accessToken') ?? '';
  return {'refreshToken': refreshToken, 'accessToken': accessToken};
}
Future<void> saveTokenSP(String accessToken) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('accessToken', accessToken);
}

Future<void> refreshTokens(String rToken) async {
  // URL для обновления токена
  Uri url = Uri.parse('http://0.0.0.0:8000/api/token/refresh/');

  // Тело запроса с токеном обновления
  Map<String, String> body = {
    'refresh': rToken,
  };

  // Отправка POST запроса на обновление токена
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    // Обработка ответа
    if (response.statusCode == 200) {
      // Токены успешно обновлены, можно сохранить их и использовать для дальнейших запросов
      // Получаем данные ответа
      final responseData = json.decode(response.body);

      // Сохраняем токены в SharedPreferences
      await saveTokenSP(responseData['access']);
      print('Токены успешно обновлены: ${response.body}');
    } else {
      // Ошибка при обновлении токенов
      print('Ошибка при обновлении токенов: ${response.body}');
    }
  } catch (e) {
    // Обработка ошибок при отправке запроса
    print('Ошибка при отправке запроса: $e');
  }
}

void getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final refreshToken = prefs.getString('refreshToken') ?? '';
  refreshTokens(refreshToken);
  final accessToken = prefs.getString('accessToken') ?? '';
  try {
    final userData = await fetchUserData(accessToken);
    print(userData); // Вывод данных пользователя
  } catch (e) {
    print('Error: $e'); // Вывод ошибки, если она произошла
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildTitle('Профиль'),
              ElevatedButton(onPressed:  (){
                getUserData();
              }, child: Text('Обновить')),
               SizedBox(height: 20),
               _buildUserInfo(Icons.account_box_rounded, 'Имя пользователя:', "Имя"),
               SizedBox(height: 20),
               _buildUserInfo(Icons.email, 'Email:', "test@mail.ru"),
               SizedBox(height: 20),
               _buildUserInfo(Icons.call, 'Номер телефона:', ''.isEmpty ? 'Отсутствует' : "Заглушка"),
               SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Row(
      children: [
        Text(title,
          style: TextStyle(
            color: Color(0xDF290505),
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(IconData iconData, String label, String value) {
    return Row(
      children: <Widget>[
        _prefixIcon(iconData),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 1),
            Text(value,
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }

  Widget _prefixIcon(IconData iconData) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
      child: Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: Icon(
          iconData,
          size: 20,
          color: Colors.grey,
        ),
      ),
    );
  }
}
