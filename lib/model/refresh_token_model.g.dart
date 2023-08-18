// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenModel _$RefreshTokenModelFromJson(Map<String, dynamic> json) =>
    RefreshTokenModel(
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
    );

Map<String, dynamic> _$RefreshTokenModelToJson(RefreshTokenModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
