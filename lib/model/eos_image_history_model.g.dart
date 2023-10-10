// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eos_image_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EosImageHistoryModel _$EosImageHistoryModelFromJson(
        Map<String, dynamic> json) =>
    EosImageHistoryModel(
      taskId: json['task_id'] as String? ?? 'task_id',
      imgUrl: json['img_url'] as String? ?? 'img_url',
      createAt: json['create_at'] as String? ?? 'create_at',
    );

Map<String, dynamic> _$EosImageHistoryModelToJson(
        EosImageHistoryModel instance) =>
    <String, dynamic>{
      'task_id': instance.taskId,
      'img_url': instance.imgUrl,
      'create_at': instance.createAt,
    };
