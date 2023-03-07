import 'package:json_annotation/json_annotation.dart';
part 'refresh_token_model.g.dart';

@JsonSerializable(explicitToJson: true)

class RefreshTokenModel {
  RefreshTokenModel({
    required this.accessToken,
    required this.refreshToken
  });
  @JsonKey(name: 'accessToken', defaultValue: "")
  String accessToken;

  @JsonKey(name: 'refreshToken', defaultValue: "")
  String refreshToken;

  factory RefreshTokenModel.fromJson(Map<String,dynamic> data) => _$RefreshTokenModelFromJson(data);

  Map<String,dynamic> toJson() => _$RefreshTokenModelToJson(this);
}