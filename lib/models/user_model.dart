// ignore_for_file: avoid_print, use_rethrow_when_possible, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../exceptions/https_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel with ChangeNotifier {
  String? id;
  String? country;
  String? phone;

  UserModel({this.id, this.country, this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'].toString(),
      country: json['country'].toString(),
      phone: json['phone'].toString(),
    );
  }

  Future<void> register(String country, String phone) async {
    try {
      const api = 'http://192.168.0.107:5000/api/register';
      final Uri url = Uri.parse(api);
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: json.encode({
            'country': country,
            'phone': phone,
          }));
      final responseData = json.decode(response.body);
      print(responseData['message']);
      if (responseData['message'] == 'Phone number already exist') {
        throw HttpException('Phone already exist');
      }
      print(responseData);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> login(String code, String phone) async {
    try {
      const api = 'http://192.168.0.107:5000/api/login';
      final Uri url = Uri.parse(api);
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: json.encode({'phone': code + ' ' + phone}));
      final responseData = json.decode(response.body);
      if (responseData['message'] == 'Invalid phone number') {
        throw HttpException('Invalid phone number');
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("phone", responseData['phone']);
      print(responseData);
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  Future<List<UserModel>> fetchUsers() async {

    final response = await http.get(
        Uri.parse('http://192.168.0.107:5000/api/get/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    var responseJson = jsonDecode(response.body);
    print(responseJson);
    notifyListeners();
    return (responseJson as List).map((p) => UserModel.fromJson(p)).toList();
  }
}
