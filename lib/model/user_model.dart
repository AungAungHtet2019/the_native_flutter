/*
class UserModel {
  UserModel({
    required this.ID,
    required this.UserID,
    required this.UserName,
    required this.PhoneNumber,
    required this.DateOfBirth,
    required this.LoginAllow,
    required this.LockDisableBy,
    required this.LockDisableDate,
    required this.LockEnableBy,
    required this.CreatedBy,
    required this.CreatedDate,
    required this.ModifiedBy,
    required this.ModifiedDate,
    required this.Active,
    required this.ActiveDisableBy,
    required this.ActiveDisableDate,
    required this.ActiveEnableBy,
    required this.ActiveEnableDate,
    required this.ProfilePicture,
    required this. UserProfilePicture,
    required this. DomainName,
  });
  late final int ID;
  late final String UserID;
  late final String UserName;
  late final String PhoneNumber;
  late final String DateOfBirth;
  late final bool LoginAllow;
  late final String LockDisableBy;
  late final String LockDisableDate;
  late final String LockEnableBy;
  late final String CreatedBy;
  late final String CreatedDate;
  late final String ModifiedBy;
  late final String ModifiedDate;
  late final bool Active;
  late final String ActiveDisableBy;
  late final String ActiveDisableDate;
  late final String ActiveEnableBy;
  late final String ActiveEnableDate;
  late final String ProfilePicture;
  late final String UserProfilePicture;
  late final String DomainName;

  UserModel.fromJson(Map<String, dynamic> json){
    ID = json['ID'];
    UserID = json['UserID'];
    UserName = json['UserName'];
    PhoneNumber = json['PhoneNumber'];
    DateOfBirth = json['DateOfBirth'].toString();
    LoginAllow = json['Login_Allow'];
    LockDisableBy = json['LockDisableBy'];
    LockDisableDate = json['LockDisableDate'];
    LockEnableBy = json['LockEnableBy'];
    CreatedBy = json['CreatedBy'];
    CreatedDate = json['CreatedDate'];
    ModifiedBy = json['ModifiedBy'];
    ModifiedDate = json['ModifiedDate'];
    Active = json['Active'];
    ActiveDisableBy = json['ActiveDisableBy'];
    ActiveDisableDate = json['ActiveDisableDate'];
    ActiveEnableBy = json['ActiveEnableBy'];
    ActiveEnableDate = json['ActiveEnableDate'];
    ProfilePicture = json['ProfilePicture'];
    UserProfilePicture = json['UserProfilePicture'].toString();
    DomainName = json['Domain_Name'].toString();

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ID'] = ID;
    _data['UserID'] = UserID;
    _data['UserName'] = UserName;
    _data['PhoneNumber'] = PhoneNumber;
    _data['DateOfBirth'] = DateOfBirth.toString();
    _data['Login_Allow'] = LoginAllow;
    _data['LockDisableBy'] = LockDisableBy;
    _data['LockDisableDate'] = LockDisableDate;
    _data['LockEnableBy'] = LockEnableBy;
    _data['CreatedBy'] = CreatedBy;
    _data['CreatedDate'] = CreatedDate;
    _data['ModifiedBy'] = ModifiedBy;
    _data['ModifiedDate'] = ModifiedDate;
    _data['Active'] = Active;
    _data['ActiveDisableBy'] = ActiveDisableBy;
    _data['ActiveDisableDate'] = ActiveDisableDate;
    _data['ActiveEnableBy'] = ActiveEnableBy;
    _data['ActiveEnableDate'] = ActiveEnableDate;
    _data['ProfilePicture'] = ProfilePicture;
    _data['UserProfilePicture'] = UserProfilePicture;
    _data['Domain_Name'] = DomainName;
    return _data;
  }
}
*/



import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)

class UserModel {
  UserModel({
    required this.ID,
    required this.UserID,
    required this.UserName,
    required this.PhoneNumber,
    required this.DateOfBirth,
    required this.LoginAllow,
    required this.LockDisableBy,
    required this.LockDisableDate,
    required this.LockEnableBy,
    required this.CreatedBy,
    required this.CreatedDate,
    required this.ModifiedBy,
    required this.ModifiedDate,
    required this.Active,
    required this.ActiveDisableBy,
    required this.ActiveDisableDate,
    required this.ActiveEnableBy,
    required this.ActiveEnableDate,
    required this.ProfilePicture,
    required this. UserProfilePicture,
    required this. DomainName,
  });
  @JsonKey(name: 'ID', defaultValue: 0)
  int ID;

  @JsonKey(name: 'UserID', defaultValue: "UserID")
  String UserID;

  @JsonKey(name: 'UserName', defaultValue: "UserName")
  String UserName;

  @JsonKey(name: 'PhoneNumber', defaultValue: "PhoneNumber")
  String PhoneNumber;

  @JsonKey(name: 'DateOfBirth', defaultValue: "DateOfBirth")
  String DateOfBirth;

  @JsonKey(name: 'Login_Allow', defaultValue: false)
  bool LoginAllow;

  @JsonKey(name: 'LockDisableBy', defaultValue: "LockDisableBy")
  String LockDisableBy;

  @JsonKey(name: 'LockDisableDate', defaultValue: "LockDisableDate")
  String LockDisableDate;

  @JsonKey(name: 'LockEnableBy', defaultValue: "LockEnableBy")
  String LockEnableBy;

  @JsonKey(name: 'CreatedBy', defaultValue: "CreatedBy")
  String CreatedBy;

  @JsonKey(name: 'CreatedDate', defaultValue: "CreatedDate")
  String CreatedDate;

  @JsonKey(name: 'ModifiedBy', defaultValue: "ModifiedBy")
  String ModifiedBy;

  @JsonKey(name: 'ModifiedDate', defaultValue: "ModifiedDate")
  String ModifiedDate;

  @JsonKey(name: 'Active', defaultValue: false)
  bool Active;

  @JsonKey(name: 'ActiveDisableBy', defaultValue: "ActiveDisableBy")
  String ActiveDisableBy;

  @JsonKey(name: 'ActiveDisableDate', defaultValue: "ActiveDisableDate")
  String ActiveDisableDate;

  @JsonKey(name: 'ActiveEnableBy', defaultValue: "ActiveEnableBy")
  String ActiveEnableBy;

  @JsonKey(name: 'ActiveEnableDate', defaultValue: "ActiveEnableDate")
  String ActiveEnableDate;

  @JsonKey(name: 'ProfilePicture', defaultValue: "ProfilePicture")
  String ProfilePicture;

  @JsonKey(name: 'UserProfilePicture', defaultValue: "UserProfilePicture")
  String UserProfilePicture;

  @JsonKey(name: 'Domain_Name', defaultValue: "Domain_Name")
  String DomainName;

  factory UserModel.fromJson(Map<String,dynamic> data) => _$UserModelFromJson(data);

  Map<String,dynamic> toJson() => _$UserModelToJson(this);
}