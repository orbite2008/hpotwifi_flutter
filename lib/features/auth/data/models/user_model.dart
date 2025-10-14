import 'dart:convert';
import '../../domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String phonenumber;
  final String city;
  final bool phonenumberVerified;
  final String? createdate;
  final String? updatedate;
  final int? countryId;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phonenumber,
    required this.city,
    required this.phonenumberVerified,
    this.createdate,
    this.updatedate,
    this.countryId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? 0,
    email: json['email'] ?? '',
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    phonenumber: json['phonenumber'] ?? '',
    city: json['city'] ?? '',
    phonenumberVerified: json['phonenumberverified'] ?? false,
    createdate: json['createdate'],
    updatedate: json['updatedate'],
    countryId: json['countryid'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'phonenumber': phonenumber,
    'city': city,
    'phonenumberverified': phonenumberVerified,
    'createdate': createdate,
    'updatedate': updatedate,
    'countryid': countryId,
  };

  String toJsonString() => jsonEncode(toJson());
  factory UserModel.fromJsonString(String str) =>
      UserModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  UserEntity toEntity() => UserEntity(
    id: id,
    email: email,
    fullName: '$firstName $lastName',
    city: city,
  );
}
