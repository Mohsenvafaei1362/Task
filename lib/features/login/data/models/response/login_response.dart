import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'accessToken')
  final String? accessToken;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'lastName')
  final String? lastName;

  LoginResponse({
    this.accessToken,
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.image,
    this.lastName,
  });
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
