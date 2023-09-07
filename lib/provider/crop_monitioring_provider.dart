import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/eos_image_history_model.dart';
import '../utils/eos_api.dart';
import '../utils/rest_api.dart';

class CropMonitoringProvider extends ChangeNotifier{

  bool status = false;
  String viewId = "";
  String taskId = "";
  String result = "";

  //Getter for taskId flag
  String get taskID => taskId;

  List<EosImageHistoryModel> eosImageHistoryList = [];


  Future<bool> requestSearchScence(List latLongList,String userId)async{

    print("Hey requestSearchScence");
    print(DateTime.now().subtract(Duration(days:1)).toString().split(" ")[0]);


    Map body={
      "fields": [
        "sceneID",
        "cloudCoverage"
      ],
      "limit": 2,
      "page": 1,
      "search": {
        "date": {
          "from": DateTime.now().subtract(Duration(days:15)).toString().split(" ")[0],
          "to": DateTime.now().subtract(Duration(days:10)).toString().split(" ")[0],
          // "from": "2020-05-01",
          // "to": "2020-05-30",
        },
        "cloudCoverage": {
          "from": 0,
          "to": 60
        },
        "shape": {
          "type": "Polygon",
          "coordinates": [
            latLongList
          ]
        }
      },
      "sort": {
        "date": "desc"
      }
    };
    var jsonbody = json.encode(body);

    await EosApiServices.requestSearchSceneForSentinel_2(jsonbody).then((success){
      print(success);

      try{
        Map<String, dynamic> dataResponse = jsonDecode(success);
        print("requestSearchSceneForSentinel_2 data is "+dataResponse.toString());
        viewId = dataResponse['results'][0]['view_id'];
        if(viewId != ""){
          status = true;
        }
      }
      catch(exp){
        result = success;
        notifyListeners();
        return;
      }
    });

    if(viewId != ""){
      Map downloadVisualMap = {
        "type": "jpeg",
        "params": {
          "view_id": viewId,
          "bm_type": "NDVI",
          "geometry":{
            "type": "Polygon",
            "coordinates": [
              latLongList
            ]
          },
          "px_size": 2,
          "format":"jpeg",
          "colormap": "2b0040e4100279573a41138c8a30c1f2",
          "reference": "ref_datetime"
        }
      };
      var jsonbodyDownloadVisual = json.encode(downloadVisualMap);
      await EosApiServices.downloadVisual(jsonbodyDownloadVisual).then((value) async{
        print(value);
        try{
          Map<String, dynamic> dataResponse = jsonDecode(value);
          print("downloadVisual data is "+dataResponse.toString());
          print(dataResponse['task_id']);
          taskId = dataResponse['task_id'];
          if(taskId != ""){
            status = true;

            Map latLngMap = {
              "UserId":userId,
              "taskID":taskId,
              "viewID":viewId,
              "latLongList":latLongList
            };
            var jsonbodyLatLong = json.encode(latLngMap);
            await ApiService.insertTaskID_LatLong(jsonbodyLatLong).then((value) {
              result = value;
              if(value == "success"){
                status =true;
                taskId;
                notifyListeners();
              }

            });

          }
          else{
            status = false;
          }
        }
        catch(exp){
          result = value;
          notifyListeners();
          return;
        }
      });
    }

    notifyListeners();
    return status;
  }

  Future<bool> getEosAnalysedImageHistory(String userId)async{
    bool status = false;

    Map body= {
      "Data":userId,
    };
    var jsonbody = jsonEncode(body);
    try{
      EosApiServices.getEosAnalysedImageHistory(jsonbody).then((value) {

        print("++++++++++++++++++++++++"+value.toString());
        print("***********************");
        List<dynamic> datalist = jsonDecode(value);

        for(int i = 0 ; i< datalist.length; i++){
          try{
            eosImageHistoryList.add(EosImageHistoryModel.fromJson(datalist[i]));
          }
          catch(exp){
            print(exp);
            status = false;
          }
        }
        status = true;
        notifyListeners();
      });
    }
    catch(exp){
      print(exp);
      status = false;
    }


    return status;
  }


}