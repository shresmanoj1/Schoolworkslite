// To parse this JSON data, do////     final examSubmitAnswerResponse = examSubmitAnswerResponseFromJson(jsonString);import 'dart:convert';ExamSubmitAnswerResponse examSubmitAnswerResponseFromJson(String str) => ExamSubmitAnswerResponse.fromJson(json.decode(str));String examSubmitAnswerResponseToJson(ExamSubmitAnswerResponse data) => json.encode(data.toJson());class ExamSubmitAnswerResponse {  ExamSubmitAnswerResponse({    this.success,    this.answer,    this.message,  });  bool? success;  Answer? answer;  String? message;  factory ExamSubmitAnswerResponse.fromJson(Map<String, dynamic> json) => ExamSubmitAnswerResponse(    success: json["success"],    message: json["message"],    answer: json["answer"] == null ? json["answer"] : Answer.fromJson(json["answer"]),  );  Map<String, dynamic> toJson() => {    "success": success,    "message": message,    "answer": answer?.toJson(),  };}class Answer {  Answer({    this.answerType,    this.objectiveAnswers,    this.isSubjective,    this.id,    this.question,    this.answer,    this.codeAnswer,    this.username,    this.institution,    this.createdAt,    this.updatedAt,  });  String? answerType;  List<String>? objectiveAnswers;  bool? isSubjective;  String? id;  String? question;  String? answer;  String? codeAnswer;  String? username;  String? institution;  DateTime? createdAt;  DateTime? updatedAt;  factory Answer.fromJson(Map<String, dynamic> json) => Answer(    answerType: json["answerType"] == null ? null : json["answerType"],    objectiveAnswers: List<String>.from(json["objectiveAnswers"].map((x) => x)),    isSubjective: json["isSubjective"],    id: json["_id"],    question: json["question"],    answer: json["answer"],    codeAnswer: json["codeAnswer"],    username: json["username"],    institution: json["institution"],    createdAt: DateTime.parse(json["createdAt"]),    updatedAt: DateTime.parse(json["updatedAt"]),  );  Map<String, dynamic> toJson() => {    "answerType": answerType,    "objectiveAnswers": List<dynamic>.from(objectiveAnswers!.map((x) => x)),    "isSubjective": isSubjective,    "_id": id,    "question": question,    "answer": answer,    "codeAnswer": codeAnswer,    "username": username,    "institution": institution,    "createdAt": createdAt?.toIso8601String(),    "updatedAt": updatedAt?.toIso8601String(),  };}