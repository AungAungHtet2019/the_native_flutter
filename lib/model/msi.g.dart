// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'msi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MSI _$MSIFromJson(Map<String, dynamic> json) => MSI(
      min: (json['min'] as num?)?.toDouble() ?? 0.0,
      max: (json['max'] as num?)?.toDouble() ?? 0.0,
      average: (json['average'] as num?)?.toDouble() ?? 0.0,
      std: (json['std'] as num?)?.toDouble() ?? 0.0,
      variance: (json['variance'] as num?)?.toDouble() ?? 0.0,
      q1: (json['q1'] as num?)?.toDouble() ?? 0.0,
      q3: (json['q3'] as num?)?.toDouble() ?? 0.0,
      median: (json['median'] as num?)?.toDouble() ?? 0.0,
      p10: (json['p10'] as num?)?.toDouble() ?? 0.0,
      p90: (json['p90'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$MSIToJson(MSI instance) => <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'average': instance.average,
      'std': instance.std,
      'variance': instance.variance,
      'q1': instance.q1,
      'q3': instance.q3,
      'median': instance.median,
      'p10': instance.p10,
      'p90': instance.p90,
    };
