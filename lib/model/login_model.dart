import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable(explicitToJson: true)

class LoginModel {
  LoginModel({
    required this.token,
    required this.refreshToken,
    required this.expiration,
  });
  @JsonKey(name: 'token', defaultValue: "")
  String token;

  @JsonKey(name: 'refreshToken', defaultValue: "")
  String refreshToken;

  @JsonKey(name: 'expiration', defaultValue: "")
  String expiration;

  factory LoginModel.fromJson(Map<String,dynamic> data) => _$LoginModelFromJson(data);

  Map<String,dynamic> toJson() => _$LoginModelToJson(this);
}