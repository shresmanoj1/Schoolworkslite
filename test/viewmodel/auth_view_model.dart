import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:schoolworkspro_app/api/api_response.dart';
import 'package:schoolworkspro_app/api/repositories/user_repository.dart';
import 'package:schoolworkspro_app/auth_view_model.dart';
import 'package:schoolworkspro_app/request/login_request.dart';
import 'package:schoolworkspro_app/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockSharedPreferences extends Mock implements SharedPreferences {}


void main(){
  group('AuthViewModel', (){
    late AuthViewModel viewModel;
    late MockUserRepository mockUserRepository;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockUserRepository = MockUserRepository();
      mockSharedPreferences = MockSharedPreferences();
      viewModel = AuthViewModel();
      viewModel.localStorage = mockSharedPreferences;
    });

    test('login with successful credentials',()async{
      //Arrange
      final loginRequest = LoginRequest(username: 'username', password: 'password');
      final loginResponse = LoginResponse(success: true, user: User(), token: 'token');
      final expectedUserJson = jsonEncode(loginResponse.user?.toJson());

      when(mockUserRepository.login(any)).thenAnswer((_) async => loginResponse);

      //Act
      await viewModel.login();

      // loginResponse.user?.roles = [];
      // loginResponse.user?.domains = [];

      //Assert
      expect(viewModel.loginApiResponse.status, ApiResponse.completed("Complete"));
      expect(viewModel.user.toJson(), loginResponse.user?.toJson());
      verify(mockSharedPreferences.setString('_auth', expectedUserJson));
      verify(mockSharedPreferences.setString('token', loginResponse.token.toString()));
      verify(mockSharedPreferences.setString('type', loginResponse.user!.type.toString()));

    });


  });
}