import 'dart:convert';

import 'package:cipher2/cipher2.dart';
import 'package:flutter/material.dart';

import '../model/login_model.dart';
import '../utils/global.dart';
import '../utils/rest_api.dart';

class LoginProvider extends ChangeNotifier{

  LoginModel loginModel = LoginModel(token: '', refreshToken: '', expiration: '');

  bool dataReturnStatus = false;

  LoginModel get loginModelData {
    if (loginModel.token != '') {
      // print('This is the Getter of the Token ${loginModel.token}');
      return loginModel;
    }
    return loginModel;
  }

  // bool get MydataReturnStatus {
  //   return dataReturnStatus;
  // }
  //
  // void changedataReturnStatus() {
  //   dataReturnStatus= true;
  //   notifyListeners();
  // }

  Future<String> LoginUser(String phoneNo)async{

    String result = "";
    print("Hey "+phoneNo);
    String finalPlainText = phoneNo;
    String aesEncryptedData = await Cipher2.encryptAesCbc128Padding7(finalPlainText, key, iv);
    print(" _myEncryptData is "+aesEncryptedData);
    Map body={
      "Data":"$aesEncryptedData"
    };
    var jsonbody = json.encode(body);
    await ApiService.LoginUser(jsonbody).then((success) {
      print("++++++++++++++++++++++++"+success.toString());
      print("***********************");

      if(success.toString() == "401"){
        result = "401";
      }
      else if(success.toString() == "NoOK")
      {
        // throw Exception("NoOK");
        result = "NoOK";
      }
      else{
        try{
          // print("Hello a");
          LoginModel userObjectInJson = LoginModel.fromJson(json.decode(success.toString()));
          loginModel = userObjectInJson;
          notifyListeners();
          // print("Hello b");
          // print(loginModel);
          result = "OK";
        }
        catch(exp){
          print("exp is "+exp.toString());
          result =  exp.toString();
        }
      }
    });
    return result;
  }


  // LoginModel get LoginModelData => loginModel;
  // bool get DataReturnStatus => dataReturnStatus;
}
