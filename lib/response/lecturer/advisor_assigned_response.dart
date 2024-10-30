// To parse this JSON data, do////     final adivsorAssignedLecturerResponse = adivsorAssignedLecturerResponseFromJson(jsonString);import 'dart:convert';AdivsorAssignedLecturerResponse adivsorAssignedLecturerResponseFromJson(String str) => AdivsorAssignedLecturerResponse.fromJson(json.decode(str));String adivsorAssignedLecturerResponseToJson(AdivsorAssignedLecturerResponse data) => json.encode(data.toJson());class AdivsorAssignedLecturerResponse {  AdivsorAssignedLecturerResponse({    this.success,    this.message,    this.assigned,  });  bool? success;  String? message;  List<Assigned>? assigned;  factory AdivsorAssignedLecturerResponse.fromJson(Map<String, dynamic> json) => AdivsorAssignedLecturerResponse(    success: json["success"],    message: json["message"],    assigned: List<Assigned>.from(json["assigned"].map((x) => Assigned.fromJson(x))),  );  Map<String, dynamic> toJson() => {    "success": success,    "message": message,    "assigned":  List<dynamic>.from(assigned!.map((x) => x.toJson())),  };}class Assigned {  Assigned({    this.id,    this.admission,    this.paid,    this.discount,    this.firstName,    this.lastName,    this.email,    this.contact,    this.dob,    this.gender,    this.fatherName,    this.fatherContact,    this.motherName,    this.motherContact,    this.guardianName,    this.guardianContact,    this.province,    this.city,    this.address,    this.tempProvince,    this.tempDistrict,    this.tempMunicipality,    this.tempWard,    this.tempNearestlandmark,    this.school,    this.prevSchoolAddress,    this.prevSchoolBoard,    this.percentage,    this.schoolPassedYear,    this.schoolPassedLevel,    this.college,    this.prevCollegeAddress,    this.background,    this.faculty,    this.prevCollegeGpa,    this.collegePassedYear,    this.source,    this.sourceName,    this.course,    this.communication,    this.institution,    this.createdAt,    this.assignedTo,    this.feedbacks,    this.score,    this.followedUpBy,    this.referral,  });  String? id;  String? admission;  dynamic paid;  int? discount;  String? firstName;  String? lastName;  String? email;  String? contact;  String? dob;  String? gender;  String? fatherName;  String? fatherContact;  String? motherName;  String? motherContact;  String? guardianName;  String? guardianContact;  String? province;  String? city;  String? address;  String? tempProvince;  String? tempDistrict;  String? tempMunicipality;  String? tempWard;  String? tempNearestlandmark;  String? school;  String? prevSchoolAddress;  String? prevSchoolBoard;  String? percentage;  String? schoolPassedYear;  String? schoolPassedLevel;  String? college;  String? prevCollegeAddress;  String? background;  String? faculty;  String? prevCollegeGpa;  String? collegePassedYear;  String? source;  String? sourceName;  String? course;  String? communication;  String? institution;  DateTime? createdAt;  String? assignedTo;  String? feedbacks;  Score? score;  String? followedUpBy;  String? referral;  factory Assigned.fromJson(Map<String, dynamic> json) => Assigned(    id: json["_id"],    admission: json["admission"] ?? null,    paid: json["paid"],    discount: json["discount"],    firstName: json["firstName"],    lastName: json["lastName"],    email: json["email"],    contact: json["contact"],    dob: json["dob"],    gender: json["gender"],    fatherName: json["fatherName"],    fatherContact: json["fatherContact"],    motherName: json["motherName"],    motherContact: json["motherContact"],    guardianName: json["guardianName"],    guardianContact: json["guardianContact"],    province: json["province"],    city: json["city"],    address: json["address"],    tempProvince: json["temp_province"],    tempDistrict: json["temp_district"],    tempMunicipality: json["temp_municipality"],    tempWard: json["temp_ward"],    tempNearestlandmark: json["temp_nearestlandmark"],    school: json["school"],    prevSchoolAddress: json["prev_school_address"],    prevSchoolBoard: json["prev_school_board"],    percentage: json["percentage"],    schoolPassedYear: json["school_passed_year"],    schoolPassedLevel: json["school_passed_level"],    college: json["college"],    prevCollegeAddress: json["prev_college_address"],    background: json["background"],    faculty: json["faculty"],    prevCollegeGpa: json["prev_college_gpa"],    collegePassedYear: json["college_passed_year"],    source: json["source"],    sourceName: json["source_name"],    course: json["course"],    communication: json["communication"],    institution: json["institution"],    createdAt: DateTime.parse(json["createdAt"]),    assignedTo: json["assignedTo"],    feedbacks: json["feedbacks"],    followedUpBy: json["followedUpBy"],    score: json["score"] == null ? null : Score.fromJson(json["score"]),    referral: json["referral"],  );  Map<String, dynamic> toJson() => {    "_id": id,    "admission": admission ?? null,    "paid": paid,    "discount": discount,    "firstName": firstName,    "lastName": lastName,    "email": email,    "contact": contact,    "dob": dob,    "gender": gender,    "fatherName": fatherName,    "fatherContact": fatherContact,    "motherName": motherName,    "motherContact": motherContact,    "guardianName": guardianName,    "guardianContact": guardianContact,    "province": province,    "city": city,    "address": address,    "temp_province": tempProvince,    "temp_district": tempDistrict,    "temp_municipality": tempMunicipality,    "temp_ward": tempWard,    "temp_nearestlandmark": tempNearestlandmark,    "school": school,    "prev_school_address": prevSchoolAddress,    "prev_school_board": prevSchoolBoard,    "percentage": percentage,    "school_passed_year": schoolPassedYear,    "school_passed_level": schoolPassedLevel,    "college": college,    "prev_college_address": prevCollegeAddress,    "background": background,    "faculty": faculty,    "prev_college_gpa": prevCollegeGpa,    "college_passed_year": collegePassedYear,    "source": source,    "source_name": sourceName,    "course": course,    "communication": communication,    "institution": institution,    "createdAt": createdAt?.toIso8601String(),    "assignedTo": assignedTo,    "feedbacks": feedbacks,    "followedUpBy": followedUpBy,    "score": score == null ? null : score!.toJson(),    "referral": referral,  };}class Score {  Score({    this.obtainedScore,    this.totalScore,  });  int? obtainedScore;  int? totalScore;  factory Score.fromJson(Map<String, dynamic> json) => Score(    obtainedScore: json["obtainedScore"],    totalScore: json["totalScore"],  );  Map<String, dynamic> toJson() => {    "obtainedScore": obtainedScore,    "totalScore": totalScore,  };}