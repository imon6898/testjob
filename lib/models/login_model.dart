// To parse this JSON data, do
//
//     final accountCredentials = accountCredentialsFromJson(jsonString);

import 'dart:convert';

AccountCredentials accountCredentialsFromJson(String str) => AccountCredentials.fromJson(json.decode(str));

String accountCredentialsToJson(AccountCredentials data) => json.encode(data.toJson());

class AccountCredentials {
  bool? success;
  User? user;
  String? token;

  AccountCredentials({
    this.success,
    this.user,
    this.token,
  });

  factory AccountCredentials.fromJson(Map<String, dynamic> json) => AccountCredentials(
    success: json["success"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? mobileNumber;
  dynamic otp;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.mobileNumber,
    this.otp,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    mobileNumber: json["mobile_number"],
    otp: json["otp"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "mobile_number": mobileNumber,
    "otp": otp,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
