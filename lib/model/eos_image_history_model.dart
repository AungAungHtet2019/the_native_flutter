import 'package:json_annotation/json_annotation.dart';
part 'eos_image_history_model.g.dart';

@JsonSerializable(explicitToJson: true)

class EosImageHistoryModel {
  EosImageHistoryModel({
    required this.taskId,
    required this.createAt
});
  @JsonKey(name: 'task_id', defaultValue: "task_id")
  String taskId;

  @JsonKey(name: 'create_at', defaultValue: "create_at")
  String createAt;

  factory EosImageHistoryModel.fromJson(Map<String,dynamic> data) => _$EosImageHistoryModelFromJson(data);

  Map<String,dynamic> toJson() => _$EosImageHistoryModelToJson(this);
}