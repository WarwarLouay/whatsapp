// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MessageModel with ChangeNotifier {
  String? type;
  String? message;
  String? sourceId;
  String? targetId;
  String? time;

  MessageModel({this.type, this.message, this.sourceId, this.targetId, this.time});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'].toString(),
      sourceId: json['sourceId'].toString(),
      targetId: json['targetId'].toString(),
      time: json['time'].toString(),
    );
  }

  Future<void> sendMessage(String message, String sourceId, String targetId, String time) async {
    try {
      const api = 'http://192.168.0.107:5000/api/send/message';
      final Uri url = Uri.parse(api);
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: json.encode({
            'sourceId': sourceId,
            'targetId': targetId,
            'message': message,
            'time': time,
          }));
      final responseData = json.decode(response.body);
      print(responseData);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<List<MessageModel>> fetchMessages(String sourceId, String targetId) async {

    final response = await http.post(
        Uri.parse('http://192.168.0.107:5000/api/get/message'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode({
            'sourceId': sourceId,
            'targetId': targetId,
          }));

    var responseJson = jsonDecode(response.body);
    print(responseJson);
    notifyListeners();
    return (responseJson as List).map((p) => MessageModel.fromJson(p)).toList();
  }
}
