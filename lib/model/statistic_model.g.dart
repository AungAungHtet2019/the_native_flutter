// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticModel _$StatisticModelFromJson(Map<String, dynamic> json) =>
    StatisticModel(
      sceneId: json['scene_id'] as String? ?? 'scene_id',
      viewId: json['view_id'] as String? ?? 'view_id',
      date: json['date'] as String? ?? 'date',
      cloud: (json['cloud'] as num?)?.toDouble() ?? 0.0,
      notes: json['notes'] as List<dynamic>? ?? [],
      indexes: json['indexes'] == null
          ? null
          : Indexes.fromJson(json['indexes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StatisticModelToJson(StatisticModel instance) =>
    <String, dynamic>{
      'scene_id': instance.sceneId,
      'view_id': instance.viewId,
      'date': instance.date,
      'cloud': instance.cloud,
      'notes': instance.notes,
      'indexes': instance.indexes?.toJson(),
    };
