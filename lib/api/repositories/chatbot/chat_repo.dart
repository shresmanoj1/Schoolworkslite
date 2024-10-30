import 'dart:convert';

import 'package:schoolworkspro_app/api/api.dart';

import '../../../response/chat_bot_response.dart';

class ChatBotRepo {
  API api = API();

  Future<List<Map<String, dynamic>>> getResponse(dynamic datas) async {
    API api = API();
    dynamic response;
    List<Map<String, dynamic>> res;
    try {
      response = await api.postChat(datas);
      res = List<Map<String, dynamic>>.from(
          response.map((element) => Map<String, dynamic>.from(element)));

    } catch (e) {
      print(e.toString());
      res = List<Map<String, dynamic>>.from(
          response.map((element) => Map<String, dynamic>.from(element)));
    }
    return res;
  }

  Future<List<Map<String, dynamic>>> getResponseLecturer(dynamic datas) async {
    API api = API();
    dynamic response;
    List<Map<String, dynamic>> res;
    try {
      response = await api.postChatLecturer(datas);
      res = List<Map<String, dynamic>>.from(
          response.map((element) => Map<String, dynamic>.from(element)));

    } catch (e) {
      print(e.toString());
      res = List<Map<String, dynamic>>.from(
          response.map((element) => Map<String, dynamic>.from(element)));
    }
    return res;
  }


  Future<List<Map<String, dynamic>>> getResponseAdmin(dynamic datas) async {
    API api = API();
    dynamic response;
    List<Map<String, dynamic>> res;
    try {
      response = await api.postChatAdmin(datas);
      res = List<Map<String, dynamic>>.from(
          response.map((element) => Map<String, dynamic>.from(element)));

    } catch (e) {
      print(e.toString());
      res = List<Map<String, dynamic>>.from(
          response.map((element) => Map<String, dynamic>.from(element)));
    }
    return res;
  }
}
