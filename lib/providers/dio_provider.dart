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
      print('登入失敗錯誤: $e');
      return false;
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

  Future<dynamic> bookAppointment(
    String date,
    String day,
    String time,
    int doctor,
    String token,
  ) async {
    try {
      var response = await Dio().post(
        'http://127.0.0.1:8000/api/book',
        data: {'date': date, 'day': day, 'time': time, 'doctor_id': doctor},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getAppointments(String token) async {
    try {
      var response = await Dio().get(
        'http://127.0.0.1:8000/api/appointments',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200 && response.data != '') {
        return json.encode(response.data);
      } else {
        return 'Error';
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> storeReviews(
    String reviews,
    double ratings,
    int id,
    int doctor,
    String token,
  ) async {
    try {
      var response = await Dio().post(
        'http://127.0.0.1:8000/api/reviews',
        data: {
          'reviews': reviews,
          'ratings': ratings,
          'appointment_id': id,
          'doctor_id': doctor,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> storeFavDoc(List<dynamic> favList, String token) async {
    try {
      var response = await Dio().post(
        'http://127.0.0.1:8000/api/fav',
        data: {'favList': favList},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> logout(String token) async {
    try {
      var response = await Dio().post(
        'http://127.0.0.1:8000/api/logout',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (e) {
      return e;
    }
  }
}
