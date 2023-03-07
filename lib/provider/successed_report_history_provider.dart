import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/report_history_model.dart';
import '../utils/rest_api.dart';

class SuccessedReportHistoryProvider extends ChangeNotifier{


  List<ReportHistory> successedReportHistoryModel = [];
  bool dataReturnStatus = false;


  bool get MydataReturnStatus {
    return dataReturnStatus;
  }

  void changedataReturnStatus() {
    dataReturnStatus= true;
    notifyListeners();
  }


  void getSuccessedReportHistory(String groupID)async{

    Map body={
      'data':groupID,
    };
    var jsonbody = json.encode(body);
    try{
      await ApiService.getSuccessedReportHistory(jsonbody).then((success) {
        print("++++++++++++++++++++++++"+success.toString());
        print("***********************");
        if(success.toString() == ""){
          notifyListeners();
          changedataReturnStatus();
          return;
        }
        List<dynamic> list = json.decode(success);
        print("getSuccessedReportHistory data is ** "+list.toString());
        successedReportHistoryModel.clear();
        for(int i = 0; i < list.length; i++){
          try{
            successedReportHistoryModel.add(ReportHistory.fromJson(list[i]));
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

  List<ReportHistory> get SuccessedReportHistoryModel => successedReportHistoryModel;
  bool get DataReturnStatus => dataReturnStatus;

}