import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/report_history_model.dart';
import '../utils/rest_api.dart';

class ReportHistoryProvider extends ChangeNotifier{


  List<ReportHistory> reportHistoryModel = [];
  bool dataReturnStatus = false;


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

  List<ReportHistory> get ReportHistoryModel => reportHistoryModel;
  bool get DataReturnStatus => dataReturnStatus;

}