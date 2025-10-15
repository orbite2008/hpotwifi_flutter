// lib/features/auth/data/models/user_model.dart

import 'dart:convert';
import '../../domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String phonenumber;
  final String city;
  final String countryCode;
  final bool phonenumberVerified;
  final String? createdate;
  final String? updatedate;
  final String? lastLoginDate;
  final bool passwordToBeChange;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phonenumber,
    required this.city,
    required this.countryCode,
    required this.phonenumberVerified,
    this.createdate,
    this.updatedate,
    this.lastLoginDate,
    this.passwordToBeChange = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? 0,
    email: json['email'] ?? '',
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    phonenumber: json['phonenumber'] ?? '',
    city: json['city'] ?? '',
    countryCode: json['countrycode']?.toString() ?? '',
    phonenumberVerified: json['phonenumberverified'] ?? false,
    createdate: json['createdate'],
    updatedate: json['updatedate'],
    lastLoginDate: json['lastlogindate'],
    passwordToBeChange: json['passwordtobechange'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'phonenumber': phonenumber,
    'city': city,
    'countrycode': countryCode,
    'phonenumberverified': phonenumberVerified,
    'createdate': createdate,
    'updatedate': updatedate,
    'lastlogindate': lastLoginDate,
    'passwordtobechange': passwordToBeChange,
  };

  String toJsonString() => jsonEncode(toJson());

  factory UserModel.fromJsonString(String str) =>
      UserModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  UserEntity toEntity() => UserEntity(
    id: id.toString(), // int → String OK maintenant
    email: email,
    fullName: '$firstName $lastName',
    phone: phonenumber,
    city: city,
  );
}
