import 'dart:convert';

import 'package:cipher2/cipher2.dart';
import 'package:the_native_flutter/model/category_model.dart';
import 'package:the_native_flutter/model/liked_category_model.dart';
import 'package:the_native_flutter/model/user_model.dart';
import 'package:the_native_flutter/utils/global.dart';
import 'package:the_native_flutter/utils/rest_api.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{

  UserModel userModel  = UserModel(
      ID: 0,
      UserID: "UserID",
      UserName: "UserName",
      PhoneNumber: "PhoneNumber",
      DateOfBirth: "DateOfBirth",
      LoginAllow: false,
      LockDisableBy: "LockDisableBy",
      LockDisableDate: "LockDisableDate",
      LockEnableBy: "LockEnableBy",
      CreatedBy: "CreatedBy",
      CreatedDate: "CreatedDate",
      ModifiedBy: "ModifiedBy",
      ModifiedDate: "ModifiedDate",
      Active: false,
      ActiveDisableBy: "ActiveDisableBy",
      ActiveDisableDate: "ActiveDisableDate",
      ActiveEnableBy: "ActiveEnableBy",
      ActiveEnableDate: "ActiveEnableDate",
      ProfilePicture: "ProfilePicture",
      UserProfilePicture: "UserProfilePicture",
      DomainName: "DomainName"

  );

  List<CategoryModel> categoryList = [] ; //CategoryModel(Active: '', AutoID: '', CategoryName: '', CreatedBy: '', CategoryCode: '', CreatedDate: '') as List<CategoryModel>;
  List likedCategoryList = [] ;
  //List<UserModel> userData = [];
  //bool checkUserDataLoading = false;

  /*
    @input -> phoneNO

    @output ->
    UserModel / No Data Exception
   */
  Future<String> checkUser(String phoneNo,String token)async{

    //checkUserDataLoading = true;
    //notifyListeners();

    String result = "";
    print("Hey "+phoneNo+" "+token);
    String finalPlainText = phoneNo;
    String aesEncryptedData = await Cipher2.encryptAesCbc128Padding7(finalPlainText, key, iv);
    print(" _myEncryptData is "+aesEncryptedData);
    Map body={
      "Data":"$aesEncryptedData"
    };
    var jsonbody = json.encode(body);
    await ApiService.CheckUser(jsonbody,token).then((success) {
      print("++++++++++++++++++++++++"+success.toString());
      print("***********************");
      // print("-------"+jsonData.toString());

      //checkUserDataLoading = false;
      //notifyListeners();

      if(success.toString() == "NoOK")
      {
        result = "NoOK";
      }
      else if(success.toString() == "401"){
        result = success.toString();
      }
      else{
        UserModel userObjectInJson = UserModel.fromJson(json.decode(success.toString()));
        userModel = userObjectInJson;
        notifyListeners();
        result = "0k";
      }
    });
    return result;
  }

  Future<void> getCategory()async{
    categoryList.clear();
    return await ApiService.getCategory().then((success) {
      print("++++++++++++++++++++++++"+success.toString());
      print("***********************");
      if(success.toString() == "NoOK")
      {
        throw Exception("NoOK");
      }
      else{
        // 1. return data => json string
        List<dynamic> dataList = json.decode(success);
        //List<CategoryModel> userObjectInJson = [];
        for (var element in dataList) {
          try{
            categoryList.add(CategoryModel.fromJson(element));
          }
          catch(exp,stackTrace){
            print("exp in serialization");
            print(exp);
            print(stackTrace);
          }
        }




        //List<CategoryModel> userObjectInJson = CategoryModel.fromJson(json.decode(success.toString())) as List<CategoryModel>;
        //categoryList = userObjectInJson;
        notifyListeners();
        // return categoryList;
      }
    });
  }

  Future<void> getLikedCategory(String data)async{
    likedCategoryList.clear();
    return await ApiService.getLikedCategory(data).then((success) {
      print("++++++++++++++++++++++++"+success.toString());
      print("***********************");
      if(success.toString() == "NoOK")
      {
        throw Exception("NoOK");
      }
      else{
        // 1. return data => json string
        List<dynamic> dataList = json.decode(success);
        for (var element in dataList) {
          try{
            likedCategoryList.add(LikedCategoryModel.fromJson(element).CategoryID);
          }
          catch(exp,stackTrace){
            print("exp in serialization");
            print(exp);
            print(stackTrace);
          }
        }
        notifyListeners();
      }
    });
  }


  Future<String> insertLikedCategory(String data)async{


    return await ApiService.addLikedCategory(data).then((success) {
      print("++++++++++++++++++++++++"+success.toString());
      print("***********************");
      if(success.toString() == "NoOK")
      {
        throw Exception("NoOK");
        notifyListeners();
      }
      else{

        notifyListeners();
        return success.toString();
      }
    });
  }

  Future<String> deleteLikedCategory(String data)async{


    return await ApiService.deleteLikedCategory(data).then((success) {
      print("++++++++++++++++++++++++"+success.toString());
      print("***********************");
      if(success.toString() == "NoOK")
      {
        throw Exception("NoOK");
        notifyListeners();
      }
      else{

        notifyListeners();
        return success.toString();
      }
    });
  }


}