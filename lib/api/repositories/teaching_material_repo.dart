import 'dart:convert';import 'dart:io';import 'package:dio/dio.dart';import 'package:schoolworkspro_app/api/api.dart';import 'package:schoolworkspro_app/response/common_response.dart';import 'package:schoolworkspro_app/response/lecturer/get_homework_response.dart';import 'package:schoolworkspro_app/response/student_homework_info.dart';import 'package:shared_preferences/shared_preferences.dart';import 'package:http/http.dart' as http;import '../../config/preference_utils.dart';import '../../response/teaching_material_response.dart';import '../api_exception.dart';class TeachingMaterialRepository{  API api = API();  final SharedPreferences localStorage = PreferenceUtils.instance;  Future<TeachingMaterialResponse> getTeachingMaterials(String lesson) async {    print("helloo::::::::");    API api = new API();    dynamic response;    TeachingMaterialResponse res;    try {      response = await api.getWithToken('/lessons/get-files/all/$lesson');      print(response);      res = TeachingMaterialResponse.fromJson(response);    } catch (e) {      res = TeachingMaterialResponse.fromJson(response);    }    return res;  }  Future<Commonresponse> deleteTeachingMaterial(String filename, String lessonSlug) async {    print("helloo::::::::");    API api = new API();    dynamic response;    Commonresponse res;    dynamic datas = jsonEncode({      "filename": filename,      "lessonSlug": lessonSlug    });    try {      response = await api.putDataWithToken( datas,"/lessons/delete-file");      print(response);      res = Commonresponse.fromJson(response);    } catch (e) {      res = Commonresponse.fromJson(response);    }    return res;  }  Future<Commonresponse> addTeachingMaterials(dynamic data) async {    final Dio dio = Dio();    print("[POST] :: $api_url2/lessons/add-files");    var token = localStorage.getString('token');    String fileName2 = data["medias"].split('/').last;    print(data["medias"]);    print(data["lessonSlug"]);    FormData formData = FormData.fromMap({      "medias": await MultipartFile.fromFile(data["medias"],          filename: fileName2),      "lessonSlug": data["lessonSlug"],    });    print("formdata::::${formData.fields}");    // print(formData.files.first.toString()) ;    try {      final Response response = await dio.post("$api_url2/lessons/add-files",        data: formData,        options: Options(          contentType: 'application/json',          headers: <String, String>{            'Authorization': 'Bearer ${token!}'          },        ),      );      print("check:::::::::");      if (response.statusCode == 200) {        print("20000::::::");        print(response.data);        return Commonresponse.fromJson(response.data);      } else {        throw ApiException(response.data);      }    } on SocketException {      throw ApiException("No Internet Connection");    } catch (e) {      print("RESPOSE ERR :: " + e.toString());      return Future.error(e.toString());    }  }}