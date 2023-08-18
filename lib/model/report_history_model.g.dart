// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportHistory _$ReportHistoryFromJson(Map<String, dynamic> json) =>
    ReportHistory(
      AutoID: json['Auto_ID'] as int? ?? 0,
      CaseID: json['Case_ID'] as String? ?? '0',
      PersonID: json['Person_ID'] as String? ?? '0',
      GroupID: json['Group_ID'] as String? ?? '0',
      CategoryID: json['Category_ID'] as String? ?? '0',
      DivisionID: json['Division_ID'] as String? ?? '0',
      DivisionSeeStatus: json['Division_See_Status'] as bool? ?? false,
      DistrictID: json['District_ID'] as String? ?? '0',
      DistrictSeeStatus: json['District_See_Status'] as bool? ?? false,
      TownshipID: json['Township_ID'] as String? ?? '0',
      TownshipSeeStatus: json['Township_See_Status'] as bool? ?? false,
      VillageID: json['Village_ID'] as String? ?? '0',
      CaseSubject: json['Case_Subject'] as String? ?? 'Case_Subject',
      CaseBody: json['Case_Body'] as String? ?? '0',
      RepliesStatus: json['Replies_Status'] as bool? ?? false,
      CaseFinishStatus: json['Case_Finish_Status'] as bool? ?? false,
      PublicStatus: json['Public_Status'] as bool? ?? false,
      CreatedBy: json['Created_By'] as String? ?? '0',
      CreatedDate: json['Created_Date'] as String? ?? '0',
      PersonName: json['Person_Name'] as String? ?? 'Person_Name',
      UserProfilePicture:
          json['User_Profile_Picture'] as String? ?? 'User_Profile_Picture',
      DomainName: json['Domain_Name'] as String? ?? 'Domain_Name',
      caseFile: (json['Case_File'] as List<dynamic>?)
              ?.map((e) => CaseFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      caseReplied: (json['Case_Replied'] as List<dynamic>?)
              ?.map((e) => CaseReplied.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ReportHistoryToJson(ReportHistory instance) =>
    <String, dynamic>{
      'Auto_ID': instance.AutoID,
      'Case_ID': instance.CaseID,
      'Person_ID': instance.PersonID,
      'Group_ID': instance.GroupID,
      'Category_ID': instance.CategoryID,
      'Division_ID': instance.DivisionID,
      'Division_See_Status': instance.DivisionSeeStatus,
      'District_ID': instance.DistrictID,
      'District_See_Status': instance.DistrictSeeStatus,
      'Township_ID': instance.TownshipID,
      'Township_See_Status': instance.TownshipSeeStatus,
      'Village_ID': instance.VillageID,
      'Case_Subject': instance.CaseSubject,
      'Case_Body': instance.CaseBody,
      'Replies_Status': instance.RepliesStatus,
      'Case_Finish_Status': instance.CaseFinishStatus,
      'Public_Status': instance.PublicStatus,
      'Created_By': instance.CreatedBy,
      'Created_Date': instance.CreatedDate,
      'Person_Name': instance.PersonName,
      'User_Profile_Picture': instance.UserProfilePicture,
      'Domain_Name': instance.DomainName,
      'Case_File': instance.caseFile.map((e) => e.toJson()).toList(),
      'Case_Replied': instance.caseReplied.map((e) => e.toJson()).toList(),
    };
