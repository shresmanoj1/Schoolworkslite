// To parse this JSON data, do////     final accessedModulesResponse = accessedModulesResponseFromJson(jsonString);import 'dart:convert';AccessedModulesResponse accessedModulesResponseFromJson(String str) => AccessedModulesResponse.fromJson(json.decode(str));String accessedModulesResponseToJson(AccessedModulesResponse data) => json.encode(data.toJson());class AccessedModulesResponse {  AccessedModulesResponse({    this.success,    this.modules,  });  bool? success;  List<Modules>? modules;  factory AccessedModulesResponse.fromJson(Map<String, dynamic> json) => AccessedModulesResponse(    success: json["success"],    modules: List<Modules>.from(json["modules"].map((x) => Modules.fromJson(x))),  );  Map<String, dynamic> toJson() => {    "success": success,    "modules": List<dynamic>.from(modules!.map((x) => x.toJson())),  };}class Modules {  Modules({    this.learnType,    this.tags,    this.lessons,    this.publicLessons,    this.currentBatch,    this.accessTo,    this.blockedUsers,    this.usersWithAccess,    this.isExtra,    this.branches,    this.isOptional,    this.notGraded,    this.optionalStudent,    this.id,    this.moduleTitle,    this.moduleDesc,    this.duration,    this.weeklyStudy,    this.year,    this.credit,    this.benefits,    this.moduleLeader,    this.embeddedUrl,    this.moduleSlug,    this.institution,    this.imageUrl,    this.name,    this.alias,  });  String? learnType;  List<String>? tags;  List<String>? lessons;  List<dynamic>? publicLessons;  List<String>? currentBatch;  List<String>? accessTo;  List<dynamic>? blockedUsers;  List<String>? usersWithAccess;  bool? isExtra;  List<dynamic>? branches;  bool? isOptional;  bool? notGraded;  List<dynamic>? optionalStudent;  String? id;  String? moduleTitle;  String? moduleDesc;  int? duration;  int? weeklyStudy;  String? year;  String? credit;  String? benefits;  ModuleLeader? moduleLeader;  String? embeddedUrl;  String? moduleSlug;  String? institution;  String? imageUrl;  String? name;  String? alias;  factory Modules.fromJson(Map<String, dynamic> json) => Modules(    learnType: json["learn_type"],    tags: List<String>.from(json["tags"].map((x) => x)),    lessons: List<String>.from(json["lessons"].map((x) => x)),    publicLessons: List<dynamic>.from(json["public_lessons"].map((x) => x)),    currentBatch: List<String>.from(json["currentBatch"].map((x) => x)),    accessTo: List<String>.from(json["accessTo"].map((x) => x)),    blockedUsers: List<dynamic>.from(json["blockedUsers"].map((x) => x)),    usersWithAccess: List<String>.from(json["usersWithAccess"].map((x) => x)),    isExtra: json["isExtra"],    branches: List<dynamic>.from(json["branches"].map((x) => x)),    isOptional: json["isOptional"],    notGraded: json["notGraded"],    optionalStudent: List<dynamic>.from(json["optionalStudent"].map((x) => x)),    id: json["_id"],    moduleTitle: json["moduleTitle"],    moduleDesc: json["moduleDesc"],    duration: json["duration"],    weeklyStudy: json["weekly_study"],    year: json["year"],    credit: json["credit"],    benefits: json["benefits"],    moduleLeader: ModuleLeader.fromJson(json["moduleLeader"]),    embeddedUrl: json["embeddedUrl"],    moduleSlug: json["moduleSlug"],    institution: json["institution"],    imageUrl: json["imageUrl"],    name: json["name"],    alias: json["alias"],  );  Map<String, dynamic> toJson() => {    "learn_type": learnType,    "tags": List<dynamic>.from(tags!.map((x) => x)),    "lessons": List<dynamic>.from(lessons!.map((x) => x)),    "public_lessons": List<dynamic>.from(publicLessons!.map((x) => x)),    "currentBatch": List<dynamic>.from(currentBatch!.map((x) => x)),    "accessTo": List<dynamic>.from(accessTo!.map((x) => x)),    "blockedUsers": List<dynamic>.from(blockedUsers!.map((x) => x)),    "usersWithAccess": List<dynamic>.from(usersWithAccess!.map((x) => x)),    "isExtra": isExtra,    "branches": List<dynamic>.from(branches!.map((x) => x)),    "isOptional": isOptional,    "notGraded": notGraded,    "optionalStudent": List<dynamic>.from(optionalStudent!.map((x) => x)),    "_id": id,    "moduleTitle": moduleTitle,    "moduleDesc": moduleDesc,    "duration": duration,    "weekly_study": weeklyStudy,    "year": year,    "credit": credit,    "benefits": benefits,    "moduleLeader": moduleLeader?.toJson(),    "embeddedUrl": embeddedUrl,    "moduleSlug": moduleSlug,    "institution": institution,    "imageUrl": imageUrl,    "name": name,    "alias": alias,  };}class ModuleLeader {  ModuleLeader({    this.modules,    this.id,    this.email,    this.address,    this.firstname,    this.lastname,    this.workType,    this.joinDate,    this.institution,    this.imageUrl,  });  List<String>? modules;  String? id;  String? email;  String? address;  String? firstname;  String? lastname;  String? workType;  DateTime? joinDate;  String? institution;  String? imageUrl;  factory ModuleLeader.fromJson(Map<String, dynamic> json) => ModuleLeader(    modules: List<String>.from(json["modules"].map((x) => x)),    id: json["_id"],    email: json["email"],    address: json["address"],    firstname: json["firstname"],    lastname: json["lastname"],    workType: json["workType"],    joinDate: DateTime.parse(json["joinDate"]),    institution: json["institution"],    imageUrl: json["imageUrl"],  );  Map<String, dynamic> toJson() => {    "modules": List<dynamic>.from(modules!.map((x) => x)),    "_id": id,    "email": email,    "address": address,    "firstname": firstname,    "lastname": lastname,    "workType": workType,    "joinDate": joinDate?.toIso8601String(),    "institution": institution,    "imageUrl": imageUrl,  };}