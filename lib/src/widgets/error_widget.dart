import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final Object? errorMessage;

  const ErrorScreen({Key? key, this.errorMessage}) : super(key: key);

  String getDioErrorMessage(Object? error) {
    String errorMessage = "Произошла ошибка";
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Превышено время ожидания соединения';
      } else if (error.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Превышено время ожидания получения данных';
      } else if (error.type == DioExceptionType.sendTimeout) {
        errorMessage = 'Превышено время ожидания отправки запроса';
      } else if (error.type == DioExceptionType.badResponse) {
        errorMessage = 'Неправильный код ответа сервера';
      } else if (error.type == DioExceptionType.cancel) {
        errorMessage = 'Запрос отменен';
      } else if (error.type == DioExceptionType.connectionError) {
        errorMessage = 'Произошла ошибка cоединения к базе';
      } else if (error.type == DioExceptionType.unknown) {
        errorMessage = 'Произошла ошибка';
      }
      print(error.type);
    }
    return errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    String textError = getDioErrorMessage(errorMessage);
    return ListView(
      children: [
        const Icon(
          Icons.error_outline, // Иконка ошибки
          size: 100, // Размер иконки можно настроить по своему усмотрению
          color: Colors.red, // Цвет иконки можно настроить по своему усмотрению
        ),
        const SizedBox(height: 20),
        Text(
          textError,
          textAlign: TextAlign.center,// Текст ошибки
          style: const TextStyle(
            fontSize: 25, // Размер текста можно настроить по своему усмотрению
            fontWeight: FontWeight.bold, // Начертание текста можно настроить по своему усмотрению
          ),
        ),
      ],
    );
  }
}
