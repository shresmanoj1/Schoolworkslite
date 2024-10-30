// To parse this JSON data, do
//
//     final createSubGroupResponse = createSubGroupResponseFromJson(jsonString);

import 'dart:convert';

CreateSubGroupResponse createSubGroupResponseFromJson(String str) => CreateSubGroupResponse.fromJson(json.decode(str));

String createSubGroupResponseToJson(CreateSubGroupResponse data) => json.encode(data.toJson());

class CreateSubGroupResponse {
  CreateSubGroupResponse({
    this.success,
    this.assignmentGroup,
  });

  bool? success;
  AssignmentCreateSubGroup? assignmentGroup;

  factory CreateSubGroupResponse.fromJson(Map<String, dynamic> json) => CreateSubGroupResponse(
    success: json["success"],
    assignmentGroup: AssignmentCreateSubGroup.fromJson(json["assignmentGroup"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "assignmentGroup": assignmentGroup?.toJson(),
  };
}

class AssignmentCreateSubGroup {
  AssignmentCreateSubGroup({
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
  List<dynamic>? assignmentSubGroup;
  String? id;
  String? assignment;
  String? groupName;
  String? createdBy;
  String? institution;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AssignmentCreateSubGroup.fromJson(Map<String, dynamic> json) => AssignmentCreateSubGroup(
    users: List<String>.from(json["users"].map((x) => x)),
    hasEdit: List<String>.from(json["hasEdit"].map((x) => x)),
    assignmentSubGroup: List<dynamic>.from(json["assignmentSubGroup"].map((x) => x)),
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
