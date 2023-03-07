// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_replied_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseRepliedFile _$CaseRepliedFileFromJson(Map<String, dynamic> json) {
  return CaseRepliedFile(
    AutoID: json['Auto_ID'] as int? ?? 0,
    CaseRepliedID: json['Case_Replied_ID'] as String? ?? '0',
    CaseRepliedFileSize: json['Case_Replied_File_Size'] as String? ?? '0',
    CaseRepliedFileName:
        json['Case_Replied_File_Name'] as String? ?? 'Case_File_Name',
    CaseRepliedFileExtension:
        json['Case_Replied_File_Extension'] as String? ?? 'Case_File_Extension',
    CaseRepliedFilePath:
        json['Case_Replied_File_Path'] as String? ?? 'Case_File_Path',
    DomainName: json['Domain_Name'] as String? ?? 'Domain_Name',
    CreatedBy: json['Created_By'] as String? ?? 'Created_By',
    CreatedDate: json['Created_Date'] as String? ?? 'Created_Date',
  );
}

Map<String, dynamic> _$CaseRepliedFileToJson(CaseRepliedFile instance) =>
    <String, dynamic>{
      'Auto_ID': instance.AutoID,
      'Case_Replied_ID': instance.CaseRepliedID,
      'Case_Replied_File_Size': instance.CaseRepliedFileSize,
      'Case_Replied_File_Name': instance.CaseRepliedFileName,
      'Case_Replied_File_Extension': instance.CaseRepliedFileExtension,
      'Case_Replied_File_Path': instance.CaseRepliedFilePath,
      'Domain_Name': instance.DomainName,
      'Created_By': instance.CreatedBy,
      'Created_Date': instance.CreatedDate,
    };
