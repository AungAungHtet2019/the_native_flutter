import 'package:json_annotation/json_annotation.dart';
part 'user_name_model.g.dart';

@JsonSerializable(explicitToJson: true)

class UName {
  UName({
    required this.UserName,
  });
  @JsonKey(name: 'UserName', defaultValue: null)
  String UserName;

  factory UName.fromJson(Map<String,dynamic> data) => _$UNameFromJson(data);

  Map<String,dynamic> toJson() => _$UNameToJson(this);
}