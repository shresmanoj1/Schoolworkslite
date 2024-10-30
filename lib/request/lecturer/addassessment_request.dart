// To parse this JSON data, do
//
//     final addAssessmentRequest = addAssessmentRequestFromJson(jsonString);

import 'dart:convert';

AddAssessmentRequest addAssessmentRequestFromJson(String str) => AddAssessmentRequest.fromJson(json.decode(str));

String addAssessmentRequestToJson(AddAssessmentRequest data) => json.encode(data.toJson());

class AddAssessmentRequest {
  AddAssessmentRequest({
    this.dueDate,
    this.contents,
    this.lessonSlug,
    this.batches,
  });

  DateTime ? dueDate;
  String ? contents;
  String ? lessonSlug;
  List<String> ? batches;

  factory AddAssessmentRequest.fromJson(Map<String, dynamic> json) => AddAssessmentRequest(
    dueDate: DateTime.parse(json["dueDate"]),
    contents: json["contents"],
    lessonSlug: json["lessonSlug"],
    batches: List<String>.from(json["batches"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "dueDate": dueDate?.toIso8601String(),
    "contents": contents,
    "lessonSlug": lessonSlug,
    "batches": List<dynamic>.from(batches!.map((x) => x)),
  };
}
