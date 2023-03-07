
import 'package:json_annotation/json_annotation.dart';
import 'package:the_native_flutter/model/user_name_model.dart';
import 'package:the_native_flutter/model/user_name_model.dart';
import 'admin_user_name_model.dart';
import 'case_replied_file_model.dart';
part 'case_replied_model.g.dart';

@JsonSerializable(explicitToJson: true)

class CaseReplied {
  CaseReplied({
    required this.AutoID,
    required this.CaseRepliedID,
    required this.CaseID,
    required this.PersonID,
    required this.GroupID,
    required this.CategoryID,
    required this.RepliedSubject,
    required this.RepliedBody,
    required this.CreatedBy,
    required this.CreatedDate,
    required this.caseRepliedFile,
    required this.gUserName,
    required this.UserName,
    required this.UserProfilePicture,
    required this.DomainName,


  });

  @JsonKey(name: 'Auto_ID', defaultValue: 0)
  int AutoID;

  @JsonKey(name: 'Case_Replied_ID', defaultValue: "Case_Replied_ID")
  String CaseRepliedID;

  @JsonKey(name: 'Case_ID', defaultValue: "Case_ID")
  String CaseID;

  @JsonKey(name: 'Person_ID', defaultValue: "Person_ID")
  String PersonID;

  @JsonKey(name: 'Group_ID', defaultValue: "Group_ID")
  String GroupID;

  @JsonKey(name: 'Category_ID', defaultValue: "Category_ID")
  String CategoryID;

  @JsonKey(name: 'Replied_Subject', defaultValue: "Replied_Subject")
  String RepliedSubject;

  @JsonKey(name: 'Replied_Body', defaultValue: "Replied_Body")
  String RepliedBody;

  @JsonKey(name: 'Created_By', defaultValue: "Created_By")
  String CreatedBy;

  @JsonKey(name: 'Created_Date', defaultValue: "Created_Date")
  String CreatedDate;

  @JsonKey(name: 'Case_Replied_File', defaultValue: [])
  List<CaseRepliedFile> caseRepliedFile;

  @JsonKey(name: 'G_User_Name', defaultValue: "G_User_Name")
  String gUserName;

  @JsonKey(name: 'User_Name', defaultValue: "User_Name")
  String UserName;

  @JsonKey(name: 'User_Profile_Picture', defaultValue: "User_Profile_Picture")
  String UserProfilePicture;

  @JsonKey(name: 'Domain_Name', defaultValue: "Domain_Name")
  String DomainName;

  factory CaseReplied.fromJson(Map<String,dynamic> data) => _$CaseRepliedFromJson(data);

  Map<String,dynamic> toJson() => _$CaseRepliedToJson(this);


}