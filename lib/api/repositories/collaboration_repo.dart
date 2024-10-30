
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:schoolworkspro_app/response/available_collaboration_response.dart';
import 'package:schoolworkspro_app/response/collaboration_task_group_response.dart';
import 'package:schoolworkspro_app/response/common_response.dart';
import 'package:schoolworkspro_app/response/create_sub_group_response.dart';
import 'package:schoolworkspro_app/response/create_task_response.dart';
import 'package:schoolworkspro_app/response/lecturer/getstudentformarking_response.dart';
import 'package:schoolworkspro_app/response/remove_editor_response.dart';

import '../../response/collaboration_group_response.dart';
import '../../response/lecturer/getbatch_response.dart';
import '../api.dart';
import '../endpoints.dart';

class CollaborationRepository {
  API api = API();

  Future<AvailableCollaborationResponse> getAvailableCollaboration() async {
    // Box box = HiveUtils.box;
    dynamic response;
    AvailableCollaborationResponse res;
    try {
      response = await api.getWithToken(Endpoints.availableCollaboration);
      res = AvailableCollaborationResponse.fromJson(response);
      // await box.put(Endpoints.availableCollaboration, res.toJson());
    } catch (e) {
      // response = await box.get(Endpoints.availableCollaboration);
      res = AvailableCollaborationResponse.fromJson(response);
    }
    return res;
  }

  Future<CollaborationGroupResponse> getGroup(String id) async {
    // Box box = HiveUtils.box;
    dynamic response;
    CollaborationGroupResponse res;
    try {
      response = await api.getWithToken("${Endpoints.collaborationGroup}$id");
      res = CollaborationGroupResponse.fromJson(response);
      print("RESPONSE1::::${res}");
      // await box.put(Endpoints.collaborationGroup, res.toJson());
    } catch (e) {
      // response = await box.get(Endpoints.collaborationGroup);
      res = CollaborationGroupResponse.fromJson(response);
    }
    return res;
  }

  Future<GetStudentForMarkingResponse> getStudent(String batch) async {
    // Box box = HiveUtils.box;
    dynamic response;
    GetStudentForMarkingResponse res;
    try {
      response = await api.getWithToken("${Endpoints.allStudent}$batch/student");
      res = GetStudentForMarkingResponse.fromJson(response);
      // await box.put(Endpoints.allStudent, res.toJson());
    } catch (e) {
      // response = await box.get(Endpoints.allStudent);
      res = GetStudentForMarkingResponse.fromJson(response);
    }
    return res;
  }

  Future<Commonresponse> createGroup(String data) async {

    dynamic response;
    Commonresponse res;
    try {
      response = await api.postDataWithToken(data ,Endpoints.createGroup);
      res = Commonresponse.fromJson(response);
    } catch (e) {
      res = Commonresponse.fromJson(response);
    }
    return res;
  }

  Future<CollaborationTaskGroup> getAllTask(String id) async {
    // Box box = HiveUtils.box;
    dynamic response;
    CollaborationTaskGroup res;
    try {
      response = await api.getWithToken("${Endpoints.allTasks}$id");
      res = CollaborationTaskGroup.fromJson(response);
      // await box.put(Endpoints.allTasks, res.toJson());
    } catch (e) {
      // response = await box.get(Endpoints.allTasks);
      res = CollaborationTaskGroup.fromJson(response);
    }
    return res;
  }

  Future<CreateSubGroupResponse> createSubGroup(String id, String data) async {
    dynamic response;
    CreateSubGroupResponse res;
    try {
      response = await api.postDataWithToken(data ,"${Endpoints.createSubGroup}$id");
      res = CreateSubGroupResponse.fromJson(response);
      print("STATUS:::${res.success}");
      print("RESPONSE:::${res.assignmentGroup}");
    } catch (e) {
      res = CreateSubGroupResponse.fromJson(response);
    }
    return res;
  }

  Future<CreateTaskResponse> createTaskGroup(String id, String data, bool isUpdate) async {
    dynamic response;
    CreateTaskResponse res;
    try {
      print("REQUEST22::::${data.toString()}");
      response = isUpdate ? await api.putDataWithToken(data,"${Endpoints.updateTaskGroup}$id") :
      await api.postDataWithToken(data ,"${Endpoints.createTaskGroup}$id");
      res = CreateTaskResponse.fromJson(response);
      print("RESPONSE::${res.toJson()}");

    } catch (e) {
      print("ERROR::::${e.toString()}");
      res = CreateTaskResponse.fromJson(response);
    }
    return res;
  }

  Future<dynamic> deleteGroup(String id,) async {
    print("yess");
    dynamic response;
    Commonresponse res;
    try {
      response = await api.deleteWithToken("${Endpoints.deleteGroup}$id");
      res = Commonresponse.fromJson(response);
      print("RES::$res");

    } catch (e) {
      res = Commonresponse.fromJson(response);
      print("RES::$res");
    }
    return res;
  }

  Future<RemoveEditorResponse> removeEditor(String data) async {
    dynamic response;
    RemoveEditorResponse res;
    print("REQUEST:::${data.toString()}");
    try {
      response = await api.putDataWithToken(data ,Endpoints.removeGroupMembers);
      res = RemoveEditorResponse.fromJson(response);
    } catch (e) {
      res = RemoveEditorResponse.fromJson(response);
    }
    return res;
  }

  Future<RemoveEditorResponse> addMember(String data) async {
    dynamic response;
    RemoveEditorResponse res;
    print("REQUEST:::${data.toString()}");
    try {
      response = await api.putDataWithToken(data ,Endpoints.addGroupMembers);
      res = RemoveEditorResponse.fromJson(response);
    } catch (e) {
      res = RemoveEditorResponse.fromJson(response);
    }
    return res;
  }

  Future<dynamic> deleteMember(String id, String userId) async {
    print("yess");
    dynamic response;
    Commonresponse res;
    try {
      response = await api.deleteWithToken("${Endpoints.collaborationGroup}$id/users/$userId");
      res = Commonresponse.fromJson(response);
      print("RES::$res");

    } catch (e) {
      res = Commonresponse.fromJson(response);
      print("RES::$res");
    }
    return res;
  }

  Future<GetBatchResponse> getAssignmentBatch(String id) async {
    // Box box = HiveUtils.box;
    dynamic response;
    GetBatchResponse res;
    try {
      response = await api.getWithToken("${Endpoints.getAssignmentBatch}$id/batches");
      res = GetBatchResponse.fromJson(response);
      // await box.put(Endpoints.getAssignmentBatch, res.toJson());
    } catch (e) {
      // response = await box.get(Endpoints.getAssignmentBatch);
      res = GetBatchResponse.fromJson(response);
    }
    return res;
  }
}
