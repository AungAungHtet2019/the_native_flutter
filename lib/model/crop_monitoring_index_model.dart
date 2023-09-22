import 'package:json_annotation/json_annotation.dart';
part 'crop_monitoring_index_model.g.dart';

@JsonSerializable(explicitToJson: true)

class CropMonitoringIndexModel {
  CropMonitoringIndexModel({
    required this.id,
    required this.maxValue,
    required this.minValue,
    required this.description,
    required this.mmDescription,
    required this.type,
    required this.createdAt,
    required this.indexColor,
  });

  @JsonKey(name: 'id', defaultValue: 0)
  int id;

  @JsonKey(name: 'max_value', defaultValue: 0.0)
  double maxValue;

  @JsonKey(name: 'min_value', defaultValue: 0.0)
  double minValue;

  @JsonKey(name: 'description', defaultValue: "description")
  String description;

  @JsonKey(name: 'mm_description', defaultValue: "mm_description")
  String mmDescription;

  @JsonKey(name: 'type', defaultValue: "type")
  String type;

  @JsonKey(name: 'created_at', defaultValue: "created_at")
  String createdAt;

  @JsonKey(name: 'index_color', defaultValue: "index_color")
  String indexColor;

  factory CropMonitoringIndexModel.fromJson(Map<String,dynamic> data) => _$CropMonitoringIndexModelFromJson(data);

  Map<String,dynamic> toJson() => _$CropMonitoringIndexModelToJson(this);
}