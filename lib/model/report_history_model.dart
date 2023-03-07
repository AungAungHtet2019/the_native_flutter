// class ReportHistoryModel {
//   ReportHistoryModel({
//     required this.AutoID,
//     required this.CaseID,
//     required this.PersonID,
//     required this.GroupID,
//     required this.CategoryID,
//     required this.DivisionID,
//     required this.DivisionSeeStatus,
//     required this.DistrictID,
//     required this.DistrictSeeStatus,
//     required this.TownshipID,
//     required this.TownshipSeeStatus,
//     required this.VillageID,
//     required this.CaseSubject,
//     required this.CaseBody,
//     required this.RepliesStatus,
//     required this.CaseFinishStatus,
//     required this.PublicStatus,
//     required this.CreatedBy,
//     required this.CreatedDate,
//   });
//   late final String AutoID;
//   late final String CaseID;
//   late final String PersonID;
//   late final String GroupID;
//   late final String CategoryID;
//   late final String DivisionID;
//   late final String DivisionSeeStatus;
//   late final String DistrictID;
//   late final String DistrictSeeStatus;
//   late final String TownshipID;
//   late final String TownshipSeeStatus;
//   late final String VillageID;
//   late final String CaseSubject;
//   late final String CaseBody;
//   late final String RepliesStatus;
//   late final String CaseFinishStatus;
//   late final String PublicStatus;
//   late final String CreatedBy;
//   late final String CreatedDate;
//
//   ReportHistoryModel.fromJson(Map<String, dynamic> json){
//     AutoID = json['Auto_ID'].toString();
//     CaseID = json['Case_ID'].toString();
//     PersonID = json['Person_ID'].toString();
//     GroupID = json['Group_ID'].toString();
//     CategoryID = json['Category_ID'].toString();
//     DivisionID = json['Division_ID'].toString();
//     DivisionSeeStatus = json['Division_See_Status'].toString();
//     DistrictID = json['District_ID'].toString();
//     DistrictSeeStatus = json['District_See_Status'].toString();
//     TownshipID = json['Township_ID'].toString();
//     TownshipSeeStatus = json['Township_See_Status'].toString();
//     VillageID = json['Village_ID'].toString();
//     CaseSubject = json['Case_Subject'].toString();
//     CaseBody = json['Case_Body'].toString();
//     RepliesStatus = json['Replies_Status'].toString();
//     CaseFinishStatus = json['Case_Finish_Status'].toString();
//     PublicStatus = json['Public_Status'].toString();
//     CreatedBy = json['Created_By'].toString();
//     CreatedDate = json['Created_Date'].toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['Auto_ID'] = AutoID;
//     _data['Case_ID'] = CaseID;
//     _data['Person_ID'] = PersonID;
//     _data['Group_ID'] = GroupID;
//     _data['Category_ID'] = CategoryID;
//     _data['Division_ID'] = DivisionID;
//     _data['Division_See_Status'] = DivisionSeeStatus;
//     _data['District_ID'] = DistrictID;
//     _data['District_See_Status'] = DistrictSeeStatus;
//     _data['Township_ID'] = TownshipID;
//     _data['Township_See_Status'] = TownshipSeeStatus;
//     _data['Village_ID'] = VillageID;
//     _data['Case_Subject'] = CaseSubject;
//     _data['Case_Body'] = CaseBody;
//     _data['Replies_Status'] = RepliesStatus;
//     _data['Case_Finish_Status'] = CaseFinishStatus;
//     _data['Public_Status'] = PublicStatus;
//     _data['Created_By'] = CreatedBy;
//     _data['Created_Date'] = CreatedDate;
//     return _data;
//   }
// }

// class ReportHistoryModel {
//   ReportHistoryModel({
//     required this.AutoID,
//     required this.CaseID,
//     required this.PersonID,
//     required this.GroupID,
//     required this.CategoryID,
//     required this.DivisionID,
//     required this.DivisionSeeStatus,
//     required this.DistrictID,
//     required this.DistrictSeeStatus,
//     required this.TownshipID,
//     required this.TownshipSeeStatus,
//     required this.VillageID,
//     required this.CaseSubject,
//     required this.CaseBody,
//     required this.RepliesStatus,
//     required this.CaseFinishStatus,
//     required this.PublicStatus,
//     required this.CreatedBy,
//     required this.CreatedDate,
//     // required this.caseFile,
//   });
//   late final String AutoID;
//   late final String CaseID;
//   late final String PersonID;
//   late final String GroupID;
//   late final String CategoryID;
//   late final String DivisionID;
//   late final String DivisionSeeStatus;
//   late final String DistrictID;
//   late final String DistrictSeeStatus;
//   late final String TownshipID;
//   late final String TownshipSeeStatus;
//   late final String VillageID;
//   late final String CaseSubject;
//   late final String CaseBody;
//   late final String RepliesStatus;
//   late final String CaseFinishStatus;
//   late final String PublicStatus;
//   late final String CreatedBy;
//   late final String CreatedDate;
//   // late final List<CaseFile> caseFile;
//
//   ReportHistoryModel.fromJson(Map<String, dynamic> json){
//     AutoID = json['Auto_ID'].toString();
//     CaseID = json['Case_ID'].toString();
//     PersonID = json['Person_ID'].toString();
//     GroupID = json['Group_ID'].toString();
//     CategoryID = json['Category_ID'].toString();
//     DivisionID = json['Division_ID'].toString();
//     DivisionSeeStatus = json['Division_See_Status'].toString();
//     DistrictID = json['District_ID'].toString();
//     DistrictSeeStatus = json['District_See_Status'].toString();
//     TownshipID = json['Township_ID'].toString();
//     TownshipSeeStatus = json['Township_See_Status'].toString();
//     VillageID = json['Village_ID'].toString();
//     CaseSubject = json['Case_Subject'].toString();
//     CaseBody = json['Case_Body'].toString();
//     RepliesStatus = json['Replies_Status'].toString();
//     CaseFinishStatus = json['Case_Finish_Status'].toString();
//     PublicStatus = json['Public_Status'].toString();
//     CreatedBy = json['Created_By'].toString();
//     CreatedDate = json['Created_Date'].toString();
//     // caseFile = List.from(json['CaseFile']).map((e)=>CaseFile.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['Auto_ID'] = AutoID;
//     _data['Case_ID'] = CaseID;
//     _data['Person_ID'] = PersonID;
//     _data['Group_ID'] = GroupID;
//     _data['Category_ID'] = CategoryID;
//     _data['Division_ID'] = DivisionID;
//     _data['Division_See_Status'] = DivisionSeeStatus;
//     _data['District_ID'] = DistrictID;
//     _data['District_See_Status'] = DistrictSeeStatus;
//     _data['Township_ID'] = TownshipID;
//     _data['Township_See_Status'] = TownshipSeeStatus;
//     _data['Village_ID'] = VillageID;
//     _data['Case_Subject'] = CaseSubject;
//     _data['Case_Body'] = CaseBody;
//     _data['Replies_Status'] = RepliesStatus;
//     _data['Case_Finish_Status'] = CaseFinishStatus;
//     _data['Public_Status'] = PublicStatus;
//     _data['Created_By'] = CreatedBy;
//     _data['Created_Date'] = CreatedDate;
//     // _data['CaseFile'] = caseFile.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }

// class CaseFile {
//   CaseFile({
//     required this.AutoID,
//     required this.CaseID,
//     required this.CaseFileSize,
//     required this.CaseFileName,
//     required this.CaseFileExtension,
//     required this.CaseFilePath,
//     required this.CreatedBy,
//     required this.CreatedDate,
//   });
//   late final String AutoID;
//   late final String CaseID;
//   late final String CaseFileSize;
//   late final String CaseFileName;
//   late final String CaseFileExtension;
//   late final String CaseFilePath;
//   late final String CreatedBy;
//   late final String CreatedDate;
//
//   CaseFile.fromJson(Map<String, dynamic> json){
//     AutoID = json['Auto_ID'].toString();
//     CaseID = json['Case_ID'].toString();
//     CaseFileSize = json['Case_File_Size'].toString();
//     CaseFileName = json['Case_File_Name'].toString();
//     CaseFileExtension = json['Case_File_Extension'].toString();
//     CaseFilePath = json['Case_File_Path'].toString();
//     CreatedBy = json['Created_By'].toString();
//     CreatedDate = json['Created_Date'].toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['Auto_ID'] = AutoID;
//     _data['Case_ID'] = CaseID;
//     _data['Case_File_Size'] = CaseFileSize;
//     _data['Case_File_Name'] = CaseFileName;
//     _data['Case_File_Extension'] = CaseFileExtension;
//     _data['Case_File_Path'] = CaseFilePath;
//     _data['Created_By'] = CreatedBy;
//     _data['Created_Date'] = CreatedDate;
//     return _data;
//   }
// }

import 'package:json_annotation/json_annotation.dart';

import 'case_file_model.dart';
import 'case_replied_model.dart';
part 'report_history_model.g.dart';

@JsonSerializable(explicitToJson: true)

class ReportHistory {
  ReportHistory({
    required this.AutoID,
    required this.CaseID,
    required this.PersonID,
    required this.GroupID,
    required this.CategoryID,
    required this.DivisionID,
    required this.DivisionSeeStatus,
    required this.DistrictID,
    required this.DistrictSeeStatus,
    required this.TownshipID,
    required this.TownshipSeeStatus,
    required this.VillageID,
    required this.CaseSubject,
    required this.CaseBody,
    required this.RepliesStatus,
    required this.CaseFinishStatus,
    required this.PublicStatus,
    required this.CreatedBy,
    required this.CreatedDate,
    required this.PersonName,
    required this.UserProfilePicture,
    required this.DomainName,
    required this.caseFile,
    required this.caseReplied,

  });

  @JsonKey(name: 'Auto_ID', defaultValue: 0)
  int AutoID;

  @JsonKey(name: 'Case_ID', defaultValue: "0")
  String CaseID;

  @JsonKey(name: 'Person_ID', defaultValue: "0")
  String PersonID;

  @JsonKey(name: 'Group_ID', defaultValue: "0")
  String GroupID;

  @JsonKey(name: 'Category_ID', defaultValue: "0")
  String CategoryID;

  @JsonKey(name: 'Division_ID', defaultValue: "0")
  String DivisionID;

  @JsonKey(name: 'Division_See_Status', defaultValue: false)
  bool DivisionSeeStatus;

  @JsonKey(name: 'District_ID', defaultValue: "0")
  String DistrictID;

  @JsonKey(name: 'District_See_Status', defaultValue: false)
  bool DistrictSeeStatus;

  @JsonKey(name: 'Township_ID', defaultValue: "0")
  String TownshipID;

  @JsonKey(name: 'Township_See_Status', defaultValue: false)
  bool TownshipSeeStatus;

  @JsonKey(name: 'Village_ID', defaultValue: "0")
  String VillageID;

  @JsonKey(name: 'Case_Subject', defaultValue: "Case_Subject")
  String CaseSubject;

  @JsonKey(name: 'Case_Body', defaultValue: "0")
  String CaseBody;

  @JsonKey(name: 'Replies_Status', defaultValue: false)
  bool RepliesStatus;

  @JsonKey(name: 'Case_Finish_Status', defaultValue: false)
  bool CaseFinishStatus;

  @JsonKey(name: 'Public_Status', defaultValue: false)
  bool PublicStatus;

  @JsonKey(name: 'Created_By', defaultValue: "0")
  String CreatedBy;

  @JsonKey(name: 'Created_Date', defaultValue: "0")
  String CreatedDate;

  @JsonKey(name: 'Person_Name', defaultValue: "Person_Name")
  String PersonName;

  @JsonKey(name: 'User_Profile_Picture', defaultValue: "User_Profile_Picture")
  String UserProfilePicture;

  @JsonKey(name: 'Domain_Name', defaultValue: "Domain_Name")
  String DomainName;

  @JsonKey(name: 'Case_File', defaultValue: [])
  List<CaseFile> caseFile;

  @JsonKey(name: 'Case_Replied', defaultValue: [])
  List<CaseReplied> caseReplied;

  factory ReportHistory.fromJson(Map<String, dynamic> json) =>  _$ReportHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ReportHistoryToJson(this);

  /*
  ReportHistoryModel.fromJson(Map<String, dynamic> json){
    AutoID = json['Auto_ID'];
    CaseID = json['Case_ID'];
    PersonID = json['Person_ID'];
    GroupID = json['Group_ID'];
    CategoryID = json['Category_ID'];
    DivisionID = json['Division_ID'];
    DivisionSeeStatus = json['Division_See_Status'];
    DistrictID = json['District_ID'];
    DistrictSeeStatus = json['District_See_Status'];
    TownshipID = json['Township_ID'];
    TownshipSeeStatus = json['Township_See_Status'];
    VillageID = json['Village_ID'];
    CaseSubject = json['Case_Subject'];
    CaseBody = json['Case_Body'];
    RepliesStatus = json['Replies_Status'];
    CaseFinishStatus = json['Case_Finish_Status'];
    PublicStatus = json['Public_Status'];
    CreatedBy = json['Created_By'];
    CreatedDate = json['Created_Date'];
    CaseFile = List.from(json['Case_File']).map((e)=>CaseFile.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Auto_ID'] = AutoID;
    _data['Case_ID'] = CaseID;
    _data['Person_ID'] = PersonID;
    _data['Group_ID'] = GroupID;
    _data['Category_ID'] = CategoryID;
    _data['Division_ID'] = DivisionID;
    _data['Division_See_Status'] = DivisionSeeStatus;
    _data['District_ID'] = DistrictID;
    _data['District_See_Status'] = DistrictSeeStatus;
    _data['Township_ID'] = TownshipID;
    _data['Township_See_Status'] = TownshipSeeStatus;
    _data['Village_ID'] = VillageID;
    _data['Case_Subject'] = CaseSubject;
    _data['Case_Body'] = CaseBody;
    _data['Replies_Status'] = RepliesStatus;
    _data['Case_Finish_Status'] = CaseFinishStatus;
    _data['Public_Status'] = PublicStatus;
    _data['Created_By'] = CreatedBy;
    _data['Created_Date'] = CreatedDate;
    _data['Case_File'] = CaseFile.map((e)=>e.toJson()).toList();
    return _data;
  }

   */
}

