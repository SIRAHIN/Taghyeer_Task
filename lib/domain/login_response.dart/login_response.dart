import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
@HiveType(typeId: 1)
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    @HiveField(0) int? id,
    @HiveField(1) String? username,
    @HiveField(2) String? email,
    @HiveField(3) String? firstName,
    @HiveField(4) String? lastName,
    @HiveField(5) String? gender,
    @HiveField(6) String? image,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}