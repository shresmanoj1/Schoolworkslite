import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:schoolworkspro_app/config/preference_utils.dart';
import 'package:schoolworkspro_app/request/login_request.dart';
import 'package:schoolworkspro_app/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/api_response.dart';
import 'api/repositories/user_repository.dart';

class AuthViewModel with ChangeNotifier {
  late SharedPreferences localStorage = PreferenceUtils.instance;
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  String _username = "";
  String _password = "";

  String get username => _username;
  String get password => _password;

  void setUsername(String user_name) {
    _username = user_name;
    notifyListeners();
  }

  void setPassword(String pass_word) {
    _password = pass_word;
    notifyListeners();
  }

  ApiResponse _loginApiResponse = ApiResponse.initial("Empty Data");
  ApiResponse get loginApiResponse => _loginApiResponse;
  User _user = User();
  User get user => _user;

  String _message = "Please check credentials and try again";
  String get message => _message;

  Future<void> login() async {
    _loginApiResponse = ApiResponse.initial("Loading");
    notifyListeners();

    dynamic data = loginRequestToJson(LoginRequest(
      username: _username,
      password: _password,
    ));

    LoginResponse res = await UserRepository().login(data);
    try {
      if (res.success == true) {
        print("USER::${res.user?.toJson()}");
        _user = res.user!;

        localStorage.setString("_auth_", jsonEncode(_user));
        localStorage.setString("token", res.token.toString());
        localStorage.setString("type", res.user!.type.toString());
        localStorage.setString("username", _username);
        localStorage.setString("password", _password);
        localStorage.setBool("changedToAdmin", false);
        localStorage.setString("domains", res.user!.domains.toString());
        localStorage.setString("drole", res.user!.drole.toString());
        localStorage.setString("droleName", res.user!.droleName.toString());


        _loginApiResponse = ApiResponse.completed(res.success.toString());
      } else {
        _message =
            res.message == null || res.message == "" || res.message == "nan"
                ? "Please check credentials and try again"
                : res.message.toString();
        _loginApiResponse = ApiResponse.error(res.success.toString());
      }
    } catch (e) {
      // TODO
      print("USER::${e.toString()}");
    }

    notifyListeners();
  }
}
