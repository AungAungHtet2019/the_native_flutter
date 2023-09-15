import 'package:json_annotation/json_annotation.dart';

import 'indexes.dart';
part 'statistic_model.g.dart';

@JsonSerializable(explicitToJson: true)

class StatisticModel {
  StatisticModel({
    required this.sceneId,
    required this.viewId,
    required this.date,
    required this.cloud,
    required this.notes,
    required this.indexes,
  });

  @JsonKey(name: 'scene_id', defaultValue: "scene_id")
  String sceneId;

  @JsonKey(name: 'view_id', defaultValue: "view_id")
  String viewId;

  @JsonKey(name: 'date', defaultValue: "date")
  String date;

  @JsonKey(name: 'cloud', defaultValue: 0)
  int cloud;

  @JsonKey(name: 'notes', defaultValue: [])
  List<dynamic> notes;

  @JsonKey(name: 'indexes', defaultValue: null)
  Indexes? indexes;

  factory StatisticModel.fromJson(Map<String,dynamic> data) => _$StatisticModelFromJson(data);

  Map<String,dynamic> toJson() => _$StatisticModelToJson(this);
}







