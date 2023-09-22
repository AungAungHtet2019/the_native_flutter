// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_monitoring_index_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CropMonitoringIndexModel _$CropMonitoringIndexModelFromJson(
        Map<String, dynamic> json) =>
    CropMonitoringIndexModel(
      id: json['id'] as int? ?? 0,
      maxValue: (json['max_value'] as num?)?.toDouble() ?? 0.0,
      minValue: (json['min_value'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? 'description',
      mmDescription: json['mm_description'] as String? ?? 'mm_description',
      type: json['type'] as String? ?? 'type',
      createdAt: json['created_at'] as String? ?? 'created_at',
      indexColor: json['index_color'] as String? ?? 'index_color',
    );

Map<String, dynamic> _$CropMonitoringIndexModelToJson(
        CropMonitoringIndexModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'max_value': instance.maxValue,
      'min_value': instance.minValue,
      'description': instance.description,
      'mm_description': instance.mmDescription,
      'type': instance.type,
      'created_at': instance.createdAt,
      'index_color': instance.indexColor,
    };
