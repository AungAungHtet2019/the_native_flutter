// class MemberModel {
//   MemberModel({
//     required this.PersonID,
//     required this.PersonName,
//     required this.PhoneNumber,
//     required this.CategoryName,
//     required this.VerifyStatus,
//     required this.GadiumCode,
//     required this.GadiumCategory,
//   });
//   late final String PersonID;
//   late final String PersonName;
//   late final String PhoneNumber;
//   late final String CategoryName;
//   late final String VerifyStatus;
//   late final String GadiumCode;
//   late final String GadiumCategory;
//
//   MemberModel.fromJson(Map<String, dynamic> json){
//     PersonID = json['Person_ID'].toString();
//     PersonName = json['Person_Name'].toString();
//     PhoneNumber = json['Phone_Number'].toString();
//     CategoryName = json['Category_Name'].toString();
//     VerifyStatus = json['Verify_Status'].toString();
//     GadiumCode = json['Gadium_Code'].toString();
//     GadiumCategory = json['Gadium_Category'].toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['Person_ID'] = PersonID.toString();
//     _data['Person_Name'] = PersonName.toString();
//     _data['Phone_Number'] = PhoneNumber.toString();
//     _data['Category_Name'] = CategoryName.toString();
//     _data['Verify_Status'] = VerifyStatus.toString();
//     _data['Gadium_Code'] = GadiumCode.toString();
//     _data['Gadium_Category'] = GadiumCategory.toString();
//     return _data;
//   }
// }

class MemberModel {
  MemberModel({
    required this.PersonID,
    required this.PersonName,
    required this.PhoneNumber,
    required this.GadiumCode,
  });
  late final String PersonID;
  late final String PersonName;
  late final String PhoneNumber;
  late final String GadiumCode;

  MemberModel.fromJson(Map<String, dynamic> json){
    PersonID = json['Person_ID'];
    PersonName = json['Person_Name'];
    PhoneNumber = json['Phone_Number'];
    GadiumCode = json['Gadium_Code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Person_ID'] = PersonID;
    _data['Person_Name'] = PersonName;
    _data['Phone_Number'] = PhoneNumber;
    _data['Gadium_Code'] = GadiumCode;
    return _data;
  }
}