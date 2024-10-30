import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:schoolworkspro_app/api/api.dart';
import 'package:schoolworkspro_app/api/endpoints.dart';
import 'package:schoolworkspro_app/response/admin/getstaff_response.dart';
import 'package:schoolworkspro_app/response/lecturer/getbatch_response.dart';
import 'package:schoolworkspro_app/response/lesson_response.dart';

import '../../../response/principal/drole_response.dart';

class StaffRepository {
  API api = API();
  Future<GetStaffResponse> getstaff() async {
    API api = new API();
    dynamic response;
    GetStaffResponse res;
    try {
      response = await api.getWithToken('/users/staff');

      res = GetStaffResponse.fromJson(response);
    } catch (e) {
      res = GetStaffResponse.fromJson(response);
    }
    return res;
  }

  Future<DRollResponse> getDRoll() async {
    API api = new API();
    dynamic response;
    DRollResponse res;
    try {
      response = await api.getWithToken('/drole/all');

      res = DRollResponse.fromJson(response);
    } catch (e) {
      res = DRollResponse.fromJson(response);
    }
    return res;
  }
}
