import 'package:schoolworkspro_app/api/api.dart';
import 'package:schoolworkspro_app/api/api_response.dart';
import 'package:schoolworkspro_app/api/endpoints.dart';

import '../../response/activity_response.dart';

class ActivityRepository {
  API api = API();

  Future<Activityresponse> getActivity(String username) async {
    dynamic response;
    Activityresponse res;
    try {
      print("${username}th");
      response = await api.getWithToken("/assessments/all-assessments/$username"
        // Endpoints.myActivitiy + username
      );
      print("RAW  RESPONSE " + response.toString());
      res = Activityresponse.fromJson(response);
    } catch (e) {
      print("REPO ERR :: " + e.toString());
      res = Activityresponse.fromJson(response);
    }
    return res;
  }
}