// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseFile _$CaseFileFromJson(Map<String, dynamic> json) => CaseFile(
      AutoID: json['Auto_ID'] as int? ?? 0,
      CaseID: json['Case_ID'] as String? ?? '0',
      CaseFileSize: json['Case_File_Size'] as String? ?? '0',
      CaseFileName: json['Case_File_Name'] as String? ?? 'Case_File_Name',
      CaseFileExtension:
          json['Case_File_Extension'] as String? ?? 'Case_File_Extension',
      CaseFilePath: json['Case_File_Path'] as String? ?? 'Case_File_Path',
      DomainName: json['Domain_Name'] as String? ?? 'Domain_Name',
      CreatedBy: json['Created_By'] as String? ?? 'Created_By',
      CreatedDate: json['Created_Date'] as String? ?? 'Created_Date',
    );

Map<String, dynamic> _$CaseFileToJson(CaseFile instance) => <String, dynamic>{
      'Auto_ID': instance.AutoID,
      'Case_ID': instance.CaseID,
      'Case_File_Size': instance.CaseFileSize,
      'Case_File_Name': instance.CaseFileName,
      'Case_File_Extension': instance.CaseFileExtension,
      'Case_File_Path': instance.CaseFilePath,
      'Domain_Name': instance.DomainName,
      'Created_By': instance.CreatedBy,
      'Created_Date': instance.CreatedDate,
    };
