// ignore_for_file: unused_element, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_bloc_api/contans/settings.dart';

class CharactersWebServices {
  Dio? dio;
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio!.get("character");
      print(response.data.toString());
      return response.data['results'];
    } on Exception catch (e) {
      print(e.toString());
      return [];
    }
  }
}
