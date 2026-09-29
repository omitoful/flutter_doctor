import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  Future<dynamic> getToken(String email, String password) async {
    try {
      var response = await Dio().post(
        'http://127.0.0.1:8000/api/login',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200 && response.data != '') {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> registerUser(String username, String email, String password) async {
    try {
      var response = await Dio().post(
        'http://127.0.0.1:8000/api/register',
        data: {'name': username, 'email': email, 'password': password},
      );
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != '') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('註冊失敗錯誤: $e');
      return false;
    }
  }

  Future<dynamic> getUser(String token) async {
    try {
      var user = await Dio().get(
        'http://127.0.0.1:8000/api/user',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (user.statusCode == 200 && user.data != '') {
        return json.encode(user.data);
      }
    } catch (e) {
      return e;
    }
  }
}
