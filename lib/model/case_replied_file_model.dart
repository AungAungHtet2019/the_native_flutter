import 'package:json_annotation/json_annotation.dart';
part 'case_replied_file_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CaseRepliedFile {
  CaseRepliedFile({
    required this.AutoID,
    required this.CaseRepliedID,
    required this.CaseRepliedFileSize,
    required this.CaseRepliedFileName,
    required this.CaseRepliedFileExtension,
    required this.CaseRepliedFilePath,
    required this.DomainName,
    required this.CreatedBy,
    required this.CreatedDate,
  });

  @JsonKey(name: 'Auto_ID', defaultValue: 0)
  int AutoID;

  @JsonKey(name: 'Case_Replied_ID', defaultValue: "0")
  String CaseRepliedID;

  @JsonKey(name: 'Case_Replied_File_Size', defaultValue: "0")
  String CaseRepliedFileSize;

  @JsonKey(name: 'Case_Replied_File_Name', defaultValue: "Case_File_Name")
  String CaseRepliedFileName;

  @JsonKey(name: 'Case_Replied_File_Extension', defaultValue: "Case_File_Extension")
  String CaseRepliedFileExtension;

  @JsonKey(name: 'Case_Replied_File_Path', defaultValue: "Case_File_Path")
  String CaseRepliedFilePath;

  @JsonKey(name: 'Domain_Name', defaultValue: "Domain_Name")
  String DomainName;

  @JsonKey(name: 'Created_By', defaultValue: "Created_By")
  String CreatedBy;

  @JsonKey(name: 'Created_Date', defaultValue: "Created_Date")
  String CreatedDate;

  factory CaseRepliedFile.fromJson(Map<String,dynamic> data) => _$CaseRepliedFileFromJson(data);

  Map<String,dynamic> toJson() => _$CaseRepliedFileToJson(this);

/*
  CaseFile.fromJson(Map<String, dynamic> json){
    AutoID = json['Auto_ID'].toString();
    CaseID = json['Case_ID'].toString();
    CaseFileSize = json['Case_File_Size'].toString();
    CaseFileName = json['Case_File_Name'].toString();
    CaseFileExtension = json['Case_File_Extension'].toString();
    CaseFilePath = json['Case_File_Path'].toString();
    CreatedBy = json['Created_By'].toString();
    CreatedDate = json['Created_Date'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Auto_ID'] = AutoID;
    _data['Case_ID'] = CaseID;
    _data['Case_File_Size'] = CaseFileSize;
    _data['Case_File_Name'] = CaseFileName;
    _data['Case_File_Extension'] = CaseFileExtension;
    _data['Case_File_Path'] = CaseFilePath;
    _data['Created_By'] = CreatedBy;
    _data['Created_Date'] = CreatedDate;
    return _data;
  }
  */


}