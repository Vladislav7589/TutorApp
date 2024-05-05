import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_app/src/providers/dio_provider.dart';


// Future<void> refreshTokens(String rToken) async {
//   // URL для обновления токена
//   Uri url = Uri.parse('http://0.0.0.0:8000/api/token/refresh/');
//
//   // Тело запроса с токеном обновления
//   Map<String, String> body = {
//     'refresh': rToken,
//   };
//
//   // Отправка POST запроса на обновление токена
//   try {
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(body),
//     );
//
//     // Обработка ответа
//     if (response.statusCode == 200) {
//       // Токены успешно обновлены, можно сохранить их и использовать для дальнейших запросов
//       // Получаем данные ответа
//       final responseData = json.decode(response.body);
//
//       // Сохраняем токены в SharedPreferences
//       await saveTokenSP(responseData['access']);
//       print('Токены успешно обновлены: ${response.body}');
//     } else {
//       // Ошибка при обновлении токенов
//       print('Ошибка при обновлении токенов: ${response.body}');
//     }
//   } catch (e) {
//     // Обработка ошибок при отправке запроса
//     print('Ошибка при отправке запроса: $e');
//   }
// }


class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});



  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userId = ref.watch(idUserProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildTitle('Профиль'),
              ElevatedButton(
                onPressed: ()   async {
                  final prefs = await SharedPreferences.getInstance();
                  final accessToken = prefs.getString('accessToken') ?? '';
                  final refreshToken = prefs.getString('refreshToken') ?? '';
                  final id = prefs.getInt('id');
                  print(accessToken);
                  print(refreshToken);
                  print(id);
                  print(userId);
                },
                child: const Text(
                  'Вывести',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: ()  {
                   ref.watch(removeUserIdProvider.future);
                  context.goNamed("home");
                },
                child: const Text(
                  'Выйти',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: ()  {
                  ref.refresh(fetchUserInfo(userId!).future);
                },
                child: const Text(
                  'Обновить',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              userId != null
                  ? ref.watch(fetchUserInfo(userId)).when(
                  data: (data) => Column(children: [
                    SizedBox(height: 20),
                    _buildUserInfo(Icons.email, 'Email:', data?.email ?? ''),
                    SizedBox(height: 20),
                    _buildUserInfo(Icons.person, 'ФИО:', '${data?.lastName ?? ''} ${data?.firstName ?? ''} ${data?.middleName ?? ''}'),
                    SizedBox(height: 20),
                    _buildUserInfo(Icons.location_city, 'Город:', data?.city ?? ''),
                    SizedBox(height: 20),
                    _buildUserInfo(Icons.check, 'Активен:', data?.isActive.toString() ?? ''),
                    SizedBox(height: 20),
                    //_buildUserInfo(Icons.date_range, 'Дата регистрации:', DateFormat('dd.MM.yyyy').format(data.dateJoined)),
                    SizedBox(height: 20),
                  ],),
                  error: (error, stack) => Text('ошибка: ${error.toString()} ${stack.toString()}'),
                  loading:() => const Center(
                    child: CircularProgressIndicator(color: Color(0xDF290505),),
                  ))
                  : Container(),
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
        Expanded(
          child: Column(
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
