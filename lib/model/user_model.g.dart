// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      ID: json['ID'] as int? ?? 0,
      UserID: json['UserID'] as String? ?? 'UserID',
      UserName: json['UserName'] as String? ?? 'UserName',
      PhoneNumber: json['PhoneNumber'] as String? ?? 'PhoneNumber',
      DateOfBirth: json['DateOfBirth'] as String? ?? 'DateOfBirth',
      LoginAllow: json['Login_Allow'] as bool? ?? false,
      LockDisableBy: json['LockDisableBy'] as String? ?? 'LockDisableBy',
      LockDisableDate: json['LockDisableDate'] as String? ?? 'LockDisableDate',
      LockEnableBy: json['LockEnableBy'] as String? ?? 'LockEnableBy',
      CreatedBy: json['CreatedBy'] as String? ?? 'CreatedBy',
      CreatedDate: json['CreatedDate'] as String? ?? 'CreatedDate',
      ModifiedBy: json['ModifiedBy'] as String? ?? 'ModifiedBy',
      ModifiedDate: json['ModifiedDate'] as String? ?? 'ModifiedDate',
      Active: json['Active'] as bool? ?? false,
      ActiveDisableBy: json['ActiveDisableBy'] as String? ?? 'ActiveDisableBy',
      ActiveDisableDate:
          json['ActiveDisableDate'] as String? ?? 'ActiveDisableDate',
      ActiveEnableBy: json['ActiveEnableBy'] as String? ?? 'ActiveEnableBy',
      ActiveEnableDate:
          json['ActiveEnableDate'] as String? ?? 'ActiveEnableDate',
      ProfilePicture: json['ProfilePicture'] as String? ?? 'ProfilePicture',
      UserProfilePicture:
          json['UserProfilePicture'] as String? ?? 'UserProfilePicture',
      DomainName: json['Domain_Name'] as String? ?? 'Domain_Name',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'ID': instance.ID,
      'UserID': instance.UserID,
      'UserName': instance.UserName,
      'PhoneNumber': instance.PhoneNumber,
      'DateOfBirth': instance.DateOfBirth,
      'Login_Allow': instance.LoginAllow,
      'LockDisableBy': instance.LockDisableBy,
      'LockDisableDate': instance.LockDisableDate,
      'LockEnableBy': instance.LockEnableBy,
      'CreatedBy': instance.CreatedBy,
      'CreatedDate': instance.CreatedDate,
      'ModifiedBy': instance.ModifiedBy,
      'ModifiedDate': instance.ModifiedDate,
      'Active': instance.Active,
      'ActiveDisableBy': instance.ActiveDisableBy,
      'ActiveDisableDate': instance.ActiveDisableDate,
      'ActiveEnableBy': instance.ActiveEnableBy,
      'ActiveEnableDate': instance.ActiveEnableDate,
      'ProfilePicture': instance.ProfilePicture,
      'UserProfilePicture': instance.UserProfilePicture,
      'Domain_Name': instance.DomainName,
    };
