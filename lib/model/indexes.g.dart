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
      ndsi: json['NDSI'] == null
          ? null
          : NDSI.fromJson(json['NDSI'] as Map<String, dynamic>),
      savi: json['SAVI'] == null
          ? null
          : SAVI.fromJson(json['SAVI'] as Map<String, dynamic>),
      ndre: json['(B08-B05)/(B08+B05)'] == null
          ? null
          : NDRE.fromJson(json['(B08-B05)/(B08+B05)'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IndexesToJson(Indexes instance) => <String, dynamic>{
      'NDVI': instance.ndvi?.toJson(),
      'MSI': instance.msi?.toJson(),
      'EVI': instance.evi?.toJson(),
      'NDSI': instance.ndsi?.toJson(),
      'SAVI': instance.savi?.toJson(),
      '(B08-B05)/(B08+B05)': instance.ndre?.toJson(),
    };
