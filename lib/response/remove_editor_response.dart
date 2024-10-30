// To parse this JSON data, do
//
//     final deleteGroupMemberResponse = deleteGroupMemberResponseFromJson(jsonString);

import 'dart:convert';

RemoveEditorResponse deleteGroupMemberResponseFromJson(String str) => RemoveEditorResponse.fromJson(json.decode(str));

String deleteGroupMemberResponseToJson(RemoveEditorResponse data) => json.encode(data.toJson());

class RemoveEditorResponse {
  RemoveEditorResponse({
    this.success,
    this.assignment,
    this.message,
  });

  bool? success;
  Assignment? assignment;
  String? message;

  factory RemoveEditorResponse.fromJson(Map<String, dynamic> json) => RemoveEditorResponse(
    success: json["success"],
    assignment: Assignment.fromJson(json["assignment"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "assignment": assignment?.toJson(),
    "message": message,
  };
}

class Assignment {
  Assignment({
    this.users,
    this.hasEdit,
    this.assignmentSubGroup,
    this.id,
    this.assignment,
    this.groupName,
    this.createdBy,
    this.institution,
    this.createdAt,
    this.updatedAt,
  });

  List<String>? users;
  List<String>? hasEdit;
  List<String>? assignmentSubGroup;
  String? id;
  String? assignment;
  String? groupName;
  String? createdBy;
  String? institution;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    users: List<String>.from(json["users"].map((x) => x)),
    hasEdit: List<String>.from(json["hasEdit"].map((x) => x)),
    assignmentSubGroup: List<String>.from(json["assignmentSubGroup"].map((x) => x)),
    id: json["_id"],
    assignment: json["assignment"],
    groupName: json["groupName"],
    createdBy: json["createdBy"],
    institution: json["institution"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users!.map((x) => x)),
    "hasEdit": List<dynamic>.from(hasEdit!.map((x) => x)),
    "assignmentSubGroup": List<dynamic>.from(assignmentSubGroup!.map((x) => x)),
    "_id": id,
    "assignment": assignment,
    "groupName": groupName,
    "createdBy": createdBy,
    "institution": institution,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
