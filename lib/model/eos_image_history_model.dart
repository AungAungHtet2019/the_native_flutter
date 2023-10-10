import 'package:json_annotation/json_annotation.dart';
part 'eos_image_history_model.g.dart';

@JsonSerializable(explicitToJson: true)

class EosImageHistoryModel {
  EosImageHistoryModel({
    required this.taskId,
    required this.imgUrl,
    required this.createAt
});
  @JsonKey(name: 'task_id', defaultValue: "task_id")
  String taskId;

  @JsonKey(name: 'img_url', defaultValue: "img_url")
  String imgUrl;

  @JsonKey(name: 'create_at', defaultValue: "create_at")
  String createAt;

  factory EosImageHistoryModel.fromJson(Map<String,dynamic> data) => _$EosImageHistoryModelFromJson(data);

  Map<String,dynamic> toJson() => _$EosImageHistoryModelToJson(this);
}