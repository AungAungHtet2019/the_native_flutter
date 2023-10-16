

import 'package:json_annotation/json_annotation.dart';

part 'ndsi.g.dart';

@JsonSerializable(explicitToJson: true)

class NDSI {
  NDSI({
    required this.min,
    required this.max,
    required this.average,
    required this.std,
    required this.variance,
    required this.q1,
    required this.q3,
    required this.median,
    required this.p10,
    required this.p90,
  });

  @JsonKey(name: 'min', defaultValue: 0.0)
  double min;

  @JsonKey(name: 'max', defaultValue: 0.0)
  double max;

  @JsonKey(name: 'average', defaultValue: 0.0)
  double average;

  @JsonKey(name: 'std', defaultValue: 0.0)
  double std;

  @JsonKey(name: 'variance', defaultValue: 0.0)
  double variance;

  @JsonKey(name: 'q1', defaultValue: 0.0)
  double q1;

  @JsonKey(name: 'q3', defaultValue: 0.0)
  double q3;

  @JsonKey(name: 'median', defaultValue: 0.0)
  double median;

  @JsonKey(name: 'p10', defaultValue: 0.0)
  double p10;

  @JsonKey(name: 'p90', defaultValue: 0.0)
  double p90;

  factory NDSI.fromJson(Map<String,dynamic> data) => _$NDSIFromJson(data);

  Map<String,dynamic> toJson() => _$NDSIToJson(this);
}