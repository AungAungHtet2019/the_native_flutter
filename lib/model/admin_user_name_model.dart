import 'package:json_annotation/json_annotation.dart';
part 'admin_user_name_model.g.dart';

@JsonSerializable(explicitToJson: true)

class GUserName {
  GUserName({
    required this.FarmUserDName,
  });
  @JsonKey(name: 'Farm_User_DName', defaultValue: null)
  String FarmUserDName;

  factory GUserName.fromJson(Map<String,dynamic> data) => _$GUserNameFromJson(data);

  Map<String,dynamic> toJson() => _$GUserNameToJson(this);
}