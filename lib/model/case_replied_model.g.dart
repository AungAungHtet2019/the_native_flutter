// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_replied_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseReplied _$CaseRepliedFromJson(Map<String, dynamic> json) {
  return CaseReplied(
    AutoID: json['Auto_ID'] as int? ?? 0,
    CaseRepliedID: json['Case_Replied_ID'] as String? ?? 'Case_Replied_ID',
    CaseID: json['Case_ID'] as String? ?? 'Case_ID',
    PersonID: json['Person_ID'] as String? ?? 'Person_ID',
    GroupID: json['Group_ID'] as String? ?? 'Group_ID',
    CategoryID: json['Category_ID'] as String? ?? 'Category_ID',
    RepliedSubject: json['Replied_Subject'] as String? ?? 'Replied_Subject',
    RepliedBody: json['Replied_Body'] as String? ?? 'Replied_Body',
    CreatedBy: json['Created_By'] as String? ?? 'Created_By',
    CreatedDate: json['Created_Date'] as String? ?? 'Created_Date',
    caseRepliedFile: (json['Case_Replied_File'] as List<dynamic>?)
            ?.map((e) => CaseRepliedFile.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    gUserName: json['G_User_Name'] as String? ?? 'G_User_Name',
    UserName: json['User_Name'] as String? ?? 'User_Name',
    UserProfilePicture:
        json['User_Profile_Picture'] as String? ?? 'User_Profile_Picture',
    DomainName: json['Domain_Name'] as String? ?? 'Domain_Name',
  );
}

Map<String, dynamic> _$CaseRepliedToJson(CaseReplied instance) =>
    <String, dynamic>{
      'Auto_ID': instance.AutoID,
      'Case_Replied_ID': instance.CaseRepliedID,
      'Case_ID': instance.CaseID,
      'Person_ID': instance.PersonID,
      'Group_ID': instance.GroupID,
      'Category_ID': instance.CategoryID,
      'Replied_Subject': instance.RepliedSubject,
      'Replied_Body': instance.RepliedBody,
      'Created_By': instance.CreatedBy,
      'Created_Date': instance.CreatedDate,
      'Case_Replied_File':
          instance.caseRepliedFile.map((e) => e.toJson()).toList(),
      'G_User_Name': instance.gUserName,
      'User_Name': instance.UserName,
      'User_Profile_Picture': instance.UserProfilePicture,
      'Domain_Name': instance.DomainName,
    };
