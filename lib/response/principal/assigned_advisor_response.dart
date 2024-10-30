// To parse this JSON data, do////     final assignedAdvisorResponse = assignedAdvisorResponseFromJson(jsonString);import 'dart:convert';AssignedAdvisorResponse assignedAdvisorResponseFromJson(String str) => AssignedAdvisorResponse.fromJson(json.decode(str));String assignedAdvisorResponseToJson(AssignedAdvisorResponse data) => json.encode(data.toJson());class AssignedAdvisorResponse {  AssignedAdvisorResponse({    this.success,    this.message,    this.assign,  });  bool? success;  String? message;  Assign? assign;  factory AssignedAdvisorResponse.fromJson(Map<String, dynamic> json) => AssignedAdvisorResponse(    success: json["success"],    message: json["message"],    assign: Assign.fromJson(json["assign"]),  );  Map<String, dynamic> toJson() => {    "success": success,    "message": message,    "assign": assign?.toJson(),  };}class Assign {  Assign({    this.admission,    this.paid,    this.discount,    this.id,    this.firstName,    this.lastName,    this.email,    this.contact,    this.dob,    this.gender,    this.fatherName,    this.fatherContact,    this.motherName,    this.motherContact,    this.guardianName,    this.guardianContact,    this.province,    this.city,    this.address,    this.tempProvince,    this.tempDistrict,    this.tempMunicipality,    this.tempWard,    this.tempNearestlandmark,    this.school,    this.prevSchoolAddress,    this.prevSchoolBoard,    this.percentage,    this.schoolPassedYear,    this.schoolPassedLevel,    this.college,    this.prevCollegeAddress,    this.background,    this.faculty,    this.prevCollegeGpa,    this.collegePassedYear,    this.source,    this.sourceName,    this.course,    this.communication,    this.institution,    this.image,    this.createdAt,    this.updatedAt,    this.v,    this.feedbacks,    this.followedUpBy,    this.referral,    this.assignedTo,  });  String? admission;  dynamic paid;  int? discount;  String? id;  String? firstName;  String? lastName;  String? email;  String? contact;  String? dob;  String? gender;  String? fatherName;  String? fatherContact;  String? motherName;  String? motherContact;  String? guardianName;  String? guardianContact;  String? province;  String? city;  String? address;  String? tempProvince;  String? tempDistrict;  String? tempMunicipality;  String? tempWard;  String? tempNearestlandmark;  String? school;  String? prevSchoolAddress;  String? prevSchoolBoard;  String? percentage;  String? schoolPassedYear;  String? schoolPassedLevel;  String? college;  String? prevCollegeAddress;  String? background;  String? faculty;  String? prevCollegeGpa;  String? collegePassedYear;  String? source;  String? sourceName;  String? course;  String? communication;  String? institution;  String? image;  DateTime? createdAt;  DateTime? updatedAt;  int? v;  String? feedbacks;  String? followedUpBy;  String? referral;  String? assignedTo;  factory Assign.fromJson(Map<String, dynamic> json) => Assign(    admission: json["admission"],    paid: json["paid"],    discount: json["discount"],    id: json["_id"],    firstName: json["firstName"],    lastName: json["lastName"],    email: json["email"],    contact: json["contact"],    dob: json["dob"],    gender: json["gender"],    fatherName: json["fatherName"],    fatherContact: json["fatherContact"],    motherName: json["motherName"],    motherContact: json["motherContact"],    guardianName: json["guardianName"],    guardianContact: json["guardianContact"],    province: json["province"],    city: json["city"],    address: json["address"],    tempProvince: json["temp_province"],    tempDistrict: json["temp_district"],    tempMunicipality: json["temp_municipality"],    tempWard: json["temp_ward"],    tempNearestlandmark: json["temp_nearestlandmark"],    school: json["school"],    prevSchoolAddress: json["prev_school_address"],    prevSchoolBoard: json["prev_school_board"],    percentage: json["percentage"],    schoolPassedYear: json["school_passed_year"],    schoolPassedLevel: json["school_passed_level"],    college: json["college"],    prevCollegeAddress: json["prev_college_address"],    background: json["background"],    faculty: json["faculty"],    prevCollegeGpa: json["prev_college_gpa"],    collegePassedYear: json["college_passed_year"],    source: json["source"],    sourceName: json["source_name"],    course: json["course"],    communication: json["communication"],    institution: json["institution"],    image: json["image"],    createdAt: DateTime.parse(json["createdAt"]),    updatedAt: DateTime.parse(json["updatedAt"]),    v: json["__v"],    feedbacks: json["feedbacks"],    followedUpBy: json["followedUpBy"],    referral: json["referral"],    assignedTo: json["assignedTo"],  );  Map<String, dynamic> toJson() => {    "admission": admission,    "paid": paid,    "discount": discount,    "_id": id,    "firstName": firstName,    "lastName": lastName,    "email": email,    "contact": contact,    "dob": dob,    "gender": gender,    "fatherName": fatherName,    "fatherContact": fatherContact,    "motherName": motherName,    "motherContact": motherContact,    "guardianName": guardianName,    "guardianContact": guardianContact,    "province": province,    "city": city,    "address": address,    "temp_province": tempProvince,    "temp_district": tempDistrict,    "temp_municipality": tempMunicipality,    "temp_ward": tempWard,    "temp_nearestlandmark": tempNearestlandmark,    "school": school,    "prev_school_address": prevSchoolAddress,    "prev_school_board": prevSchoolBoard,    "percentage": percentage,    "school_passed_year": schoolPassedYear,    "school_passed_level": schoolPassedLevel,    "college": college,    "prev_college_address": prevCollegeAddress,    "background": background,    "faculty": faculty,    "prev_college_gpa": prevCollegeGpa,    "college_passed_year": collegePassedYear,    "source": source,    "source_name": sourceName,    "course": course,    "communication": communication,    "institution": institution,    "image": image,    "createdAt": createdAt?.toIso8601String(),    "updatedAt": updatedAt?.toIso8601String(),    "__v": v,    "feedbacks": feedbacks,    "followedUpBy": followedUpBy,    "referral": referral,    "assignedTo": assignedTo,  };}