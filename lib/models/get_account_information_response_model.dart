// To parse this JSON data, do
//
//     final getAccountInformationResponse = getAccountInformationResponseFromJson(jsonString);

import 'dart:convert';

GetAccountInformationResponse getAccountInformationResponseFromJson(String str) => GetAccountInformationResponse.fromJson(json.decode(str));

String getAccountInformationResponseToJson(GetAccountInformationResponse data) => json.encode(data.toJson());

class GetAccountInformationResponse {
  int? id;
  dynamic title;
  String? firstName;
  String? lastName;
  dynamic companyName;
  DateTime? dob;
  dynamic vatNo;
  int? accessType;
  dynamic meta;
  int? points;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic profileImage;
  dynamic coverImage;

  GetAccountInformationResponse({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.companyName,
    this.dob,
    this.vatNo,
    this.accessType,
    this.meta,
    this.points,
    this.createdAt,
    this.updatedAt,
    this.profileImage,
    this.coverImage,
  });

  factory GetAccountInformationResponse.fromJson(Map<String, dynamic> json) => GetAccountInformationResponse(
    id: json["id"],
    title: json["title"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    companyName: json["company_name"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    vatNo: json["vat_no"],
    accessType: json["access_type"],
    meta: json["meta"],
    points: json["points"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    profileImage: json["profile_image"],
    coverImage: json["cover_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "first_name": firstName,
    "last_name": lastName,
    "company_name": companyName,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "vat_no": vatNo,
    "access_type": accessType,
    "meta": meta,
    "points": points,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "profile_image": profileImage,
    "cover_image": coverImage,
  };
}
