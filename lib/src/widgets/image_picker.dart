import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUploadButton extends StatefulWidget {
  @override
  _ImageUploadButtonState createState() => _ImageUploadButtonState();
}

class _ImageUploadButtonState extends State<ImageUploadButton> {
  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadImage() async {
    if (_image == null) return;

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(_image!.path, filename: "image.jpg"),
    });
    try {
      Response response = await dio.post('YOUR_API_ENDPOINT', data: formData);
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: getImage,
          child: Text('Выбрать изображение'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: uploadImage,
          child: Text('Загрузить изображение'),
        ),
      ],
    );
  }
}