import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../models/user.dart';
import '../screens/login_page.dart';

Future<void> saveTokensAndID(String refreshToken, String accessToken, int id) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('refreshToken', refreshToken);
  await prefs.setString('accessToken', accessToken);
  await prefs.setInt('id', id);
}

final dioProvider = Provider<DioClient>(
      (ref) => DioClient(),
);

final idUserProvider = StateProvider<int?>((ref) => null);

final loadUserIdProvider = FutureProvider<void>((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final id = prefs.getInt('id');
  ref.read(idUserProvider.notifier).update((state) => id);
});

final removeUserIdProvider = FutureProvider<void>((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('id');
  ref.refresh(loadUserIdProvider);
});

final fetchUserInfo = FutureProvider.family<User?, int>((ref, id) async {
  try{
    return ref.watch(dioProvider).getUserInfo(id);
  } catch (error) {
    scaffoldKey.currentState?.showSnackBar(showSnackBar("Ошибка получения данных пользователя\n$error"));
    return null;
  }
});
final registerUserProvider = FutureProvider.family<void, Map<String, dynamic>>((ref, userData) async {
  try{
  await ref.watch(dioProvider).registerUser(userData);
  ref.refresh(loadUserIdProvider);
  } catch (error) {
    scaffoldKey.currentState?.showSnackBar(showSnackBar("Ошибка регистрации\n$error"));
    // Обработка ошибки удаления данных
  }
});
final authenticateProvider = FutureProvider.family<void,Map<String, dynamic>>((ref,authData) async {
  try{
   await ref.watch(dioProvider).authenticate(authData);
   ref.refresh(loadUserIdProvider);
    } on DioException catch (e) {
    if (e.response?.statusCode == 401 || e.response?.statusCode == 500) {
      throw AuthenticationException("Неправильная почта или пароль");
    } else {
      rethrow;
    }
  }
});

class DioClient {
  final Dio dio = Dio();

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
  }
  // Future<int?> loadUserId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? userId = prefs.getInt('id');
  //   return userId;
  // }

  Future<User> getUserInfo(int id) async {
    User user;

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken') ?? '';

    Response response = await dio.get(
        'http://0.0.0.0:8000/users/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken' // Set the content-length.
          },
        ));
    var result = response.data;
    user = User.fromJson(result);

    return user;
  }
  Future<void> registerUser(Map<String, dynamic> userData) async {
    const String apiUrl = 'http://0.0.0.0:8000/api/register/';

    Response response = await dio.post(
        apiUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          },
        ),
        data: json.encode(userData));

    Map<String, dynamic> parsedData = response.data;
    await saveTokensAndID(parsedData['refresh'], parsedData['access'], parsedData['id']);
  }

  Future<void> authenticate(Map<String, dynamic> authData) async {
    const String apiUrl = 'http://0.0.0.0:8000/api/login/';

    Response response = await dio.post(
        apiUrl,
        data: json.encode(authData)
    );

    Map<String, dynamic> parsedData = response.data;
    await saveTokensAndID(parsedData['refresh'], parsedData['access'], parsedData['id']);

  }
}

SnackBar showSnackBar(String message){
  return SnackBar(
    content:  Text('Ошибка:\n${message}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
    duration: const Duration(seconds: 10),
    backgroundColor: Colors.redAccent,

    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    behavior: SnackBarBehavior.floating,

    margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
  );
}