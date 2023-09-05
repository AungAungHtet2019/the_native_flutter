import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/report_history_model.dart';
import '../utils/rest_api.dart';

class ReportHistoryProvider extends ChangeNotifier{


  List<ReportHistory> reportHistoryModel = [];
  bool dataReturnStatus = false;

  int? current_page;
  int? total_count;
  int? limit;
  int? last_page;


  bool get MydataReturnStatus {
    return dataReturnStatus;
  }

  void changedataReturnStatus() {
    dataReturnStatus= true;
    notifyListeners();
  }
  
  
  void getReportHistory(String groupID)async{

    Map body={
      'data':groupID,
    };
    var jsonbody = json.encode(body);
    try{
      await ApiService.getReportHistory(jsonbody).then((success) {
        print("++++++++++++++++++++++++"+success.toString());
        print("***********************");
        List<dynamic> list = json.decode(success);
        print("getReportHistory data is ** "+list.toString());
        reportHistoryModel.clear();
        for(int i = 0; i < list.length; i++){
          try{
            reportHistoryModel.add(ReportHistory.fromJson(list[i]));
          }
          catch(ex){
            rethrow;
          }
        }
        notifyListeners();
        changedataReturnStatus();
      });
    }
    catch(ex){
      rethrow;
    }
  }

  void getReportHistoryPagination(String groupID,String pageNumber)async{

    Map body={
      "groupId":groupID,
      "pageNumber":pageNumber
    };
    var jsonbody = json.encode(body);
    try{
      await ApiService.getReportHistoryPagination(jsonbody).then((success) {
        print("++++++++++++++++++++++++"+success.toString());
        print("***********************");
        Map<String,dynamic> dataResponse = jsonDecode(success);
        print(dataResponse);
        print("hey");

        current_page = dataResponse['current_page'];
        total_count = dataResponse['total_count'];
        limit = dataResponse['limit'];
        last_page = dataResponse['last_page'];



        List<dynamic> list = dataResponse['data'];
        print("getReportHistoryPagination data is ** "+list.toString());

        if(pageNumber == "" || pageNumber == "1"){
          reportHistoryModel.clear();
        }

        for(int i = 0; i < list.length; i++){
          try{
            reportHistoryModel.add(ReportHistory.fromJson(list[i]));
          }
          catch(ex){
            rethrow;
          }
        }
        notifyListeners();
        changedataReturnStatus();
      });
    }
    catch(ex){
      rethrow;
    }
  }


  List<ReportHistory> get ReportHistoryModel => reportHistoryModel;
  bool get DataReturnStatus => dataReturnStatus;

}