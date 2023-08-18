import 'dart:convert';

// import 'package:cipher2/cipher2.dart';
import 'package:flutter/material.dart';

import '../model/login_model.dart';
import '../model/refresh_token_model.dart';
import '../utils/global.dart';
import '../utils/rest_api.dart';

class RefreshTokenProvider extends ChangeNotifier{

  RefreshTokenModel refreshTokenModel = RefreshTokenModel(accessToken: '', refreshToken: '');

  RefreshTokenModel get refreshTokenModelData {
    if (refreshTokenModel.accessToken != '') {
      // print('This is the Getter of the refreshTokenModel ${refreshTokenModel.accessToken}');
      return refreshTokenModel;
    }
    return refreshTokenModel;
  }

  Future<String> RefreshToken(String accessTokn,String refreshToken)async{

    String result = "";
    print("Hey "+accessTokn+" "+refreshToken);
    /*
    String finalPlainText = accessTokn+","+refreshToken;
    String aesEncryptedData = await Cipher2.encryptAesCbc128Padding7(finalPlainText, key, iv);
    print(" _myEncryptData is "+aesEncryptedData);
    Map body={
      "Data":"$aesEncryptedData"
    };


     */

    Map body={
      "accessToken":"$accessTokn",
      "refreshToken":"$refreshToken"
    };
    var jsonbody = json.encode(body);
    await ApiService.RefreshToken(jsonbody).then((success) {
      print("++++++++++++++++++++++++"+success.toString());
      print("***********************");

      if(success.toString() == "NoOK")
      {
        result = "NoOK";
      }
      else if(success.toString() == "401"){
        result = "401";
      }
      else{
        try{
          print("Hello RefreshToken a");
          RefreshTokenModel userObjectInJson = RefreshTokenModel.fromJson(json.decode(success.toString()));
          refreshTokenModel = userObjectInJson;
          notifyListeners();
          print("Hello RefreshToken b");
          print(refreshTokenModel.accessToken);

          result = "ok";
        }
        catch(exp){
          print("exp is "+exp.toString());
          result = exp.toString();
        }
      }
    });
    return result;
  }
}