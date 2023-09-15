// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indexes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Indexes _$IndexesFromJson(Map<String, dynamic> json) => Indexes(
      ndvi: json['NDVI'] == null
          ? null
          : NDVI.fromJson(json['NDVI'] as Map<String, dynamic>),
      msi: json['MSI'] == null
          ? null
          : MSI.fromJson(json['MSI'] as Map<String, dynamic>),
      evi: json['EVI'] == null
          ? null
          : EVI.fromJson(json['EVI'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IndexesToJson(Indexes instance) => <String, dynamic>{
      'NDVI': instance.ndvi?.toJson(),
      'MSI': instance.msi?.toJson(),
      'EVI': instance.evi?.toJson(),
    };
