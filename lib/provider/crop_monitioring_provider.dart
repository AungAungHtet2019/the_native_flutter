import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_native_flutter/model/lat_lng_model.dart';
import 'package:the_native_flutter/model/statistic_model.dart';

import '../model/crop_monitoring_index_model.dart';
import '../model/eos_image_history_model.dart';
import '../utils/eos_api.dart';
import '../utils/rest_api.dart';

class CropMonitoringProvider extends ChangeNotifier{

  bool status = false;
  String viewId = "";
  String taskId = "";
  String result = "";

  String multiTemporaalStatisticsError = "";
  String multiTemporaalStatisticsResult = "";
  List<StatisticModel> statisticModelList = [];
  List<LatLngModel> latLngList =  [];
  List<CropMonitoringIndexModel> cropMonitoringIndexList = [];

  //Getter for taskId flag
  String get taskID => taskId;

  List<EosImageHistoryModel> eosImageHistoryList = [];


  Future<bool> requestSearchScence(List latLongList,String userId,String startDate,String endDate)async{

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
          // "from": DateTime.now().subtract(Duration(days:25)).toString().split(" ")[0],
          // "to": DateTime.now().subtract(Duration(days:15)).toString().split(" ")[0],
          // "from": "2020-05-01",
          // "to": "2020-05-30",
          "from": startDate,
          "to": endDate,
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
          "px_size": 5,
          "format":"png",
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

            await countDownTimer();
            if(timerCount == 0){
            {
              await EosApiServices.downloadImage(taskId).then((value) {
                print("downloadImage is ");
                print(value);
              });

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
                else{
                  status = false;
                  taskId;
                  notifyListeners();
                }

              });
            }}

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


  ///timer function start
  int timerCount = 0;
  countDownTimer() async {
    timerCount = 25;
    for (int x = 25; x > 0; x--) {
      await Future.delayed(Duration(seconds: 1)).then((_) {
        timerCount -= 1;
        print(timerCount);
      });
    }
  }
  ///timer function end

  Future<bool> createMultiTemporalStatistics(List latLongList,String startDat,String endDate)async{
    bool status = false;

    String statistics_task_id= "";

    Map body = {
      "type":"mt_stats",
      "params": {
        // "bm_type":["NDVI", "MSI", "EVI"],
        // "bm_type":["NDVI", "NDRE", "MSAVI","RECI","NDMI"],
        "bm_type":["NDVI","MSI","EVI","NDRE","SAVI","NDSI"],


        // "date_start":DateTime.now().subtract(Duration(days:15)).toString().split(" ")[0],
        // "date_end":DateTime.now().subtract(Duration(days:1)).toString().split(" ")[0],
        "date_start":startDat != "" ? startDat :DateTime.now().subtract(Duration(days:10)).toString().split(" ")[0],
        "date_end":endDate != "" ? endDate :DateTime.now().subtract(Duration(days:2)).toString().split(" ")[0],
        "geometry":
        {
          "coordinates":[
            latLongList
          ],
          "type":"Polygon"
        },
        "reference":"ref_20200924-00-20",
        "sensors":["sentinel2"]

      }
    };

    var jsonbody = json.encode(body);
    statisticModelList.clear();
    await EosApiServices.createMultiTemporalStatistics(jsonbody).then((value) async{
      print(value);
      try{
        Map<String, dynamic> dataResponse = jsonDecode(value);
        print("createMultiTemporalStatistics data is "+dataResponse.toString());
        print(dataResponse['task_id']);
        statistics_task_id = dataResponse['task_id'];

        if(statistics_task_id != ""){
          await countDownTimer();
          if(timerCount == 0){
            await EosApiServices.getMultiTemporalStatistics(statistics_task_id).then((value) {
              print("getMultiTemporalStatistics is ");
              print(value);

              multiTemporaalStatisticsError = "";
              Map<String,dynamic> getDataResponse = jsonDecode(value);
              // print(getDataResponse['errors'][0]['error']);
              try{

                List<dynamic> dlist = getDataResponse['result'];

                statisticModelList.clear();

                print(dlist.toString());
                if(dlist.length != 0){
                  for(int i = 0; i < dlist.length; i++){
                    try{
                      statisticModelList.add(StatisticModel.fromJson(dlist[i]));
                    }
                    catch(exp){
                      print(exp);
                    }
                  }
                  notifyListeners();
                  print("statisticModelList.length is ");
                  print(statisticModelList.length);

                }
                else{
                  multiTemporaalStatisticsError = getDataResponse['errors'][0]['error'];
                  notifyListeners();
                }
              }
              catch(exp){
                print(exp);
                multiTemporaalStatisticsError = getDataResponse['errors'][0]['error'];
                notifyListeners();
              }

            });
          }

        }
      }
      catch(exp){
        print(exp);
      }
    });

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
        eosImageHistoryList.clear();
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

  Future<bool> getMapPolygonPoints(String taskId) async{
    bool status = false;
    Map body= {
      "UserId":"",
      "TaskId":taskId,
      "viewID":"",
      "LatLongList":[[0]]
    };
    var jsonbody = jsonEncode(body);
    try{
      await EosApiServices.getMapPolygonPoints(jsonbody).then((value) {

        print("++++++++++++++++++++++++"+value.toString());
        print("***********************");
        Map<String,dynamic> dataResponse = jsonDecode(value);

        List<dynamic> datalist = dataResponse['data'];
        latLngList.clear();
        for(int i = 0 ; i< datalist.length; i++){
          try{
            latLngList.add(LatLngModel.fromJson(datalist[i]));
          }
          catch(exp){
            print(exp);
            status = false;
          }
        }
        status = true;
        latLngList;
        notifyListeners();
      });
    }
    catch(exp){
      print(exp);
      status = false;
    }

    return status;
  }

  Future<bool> getCropMonitoringIndex() async{
    bool status = false;

    try{
      await EosApiServices.getCropMonitoringIndex().then((value) {

        print("++++++++++++++++++++++++"+value.toString());
        print("***********************");
        Map<String,dynamic> dataResponse = jsonDecode(value);

        List<dynamic> datalist = dataResponse['data'];
        cropMonitoringIndexList.clear();
        for(int i = 0 ; i< datalist.length; i++){
          try{
            cropMonitoringIndexList.add(CropMonitoringIndexModel.fromJson(datalist[i]));
          }
          catch(exp){
            print(exp);
            status = false;
          }
        }
        status = true;
        cropMonitoringIndexList;
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