import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/report_history_model.dart';
import '../utils/rest_api.dart';

class SuccessedReportHistoryProvider extends ChangeNotifier{


  List<ReportHistory> successedReportHistoryModel = [];
  List<ReportHistory> successedReportHistoryByUserList = [];

  bool dataReturnStatus = false;
  bool getSuccessedReportHistoryByUserStatus = false;


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

  void getSuccessedReportHistoryPagination(String groupID,String pageNumber)async{

    Map body={
      "groupId":groupID,
      "pageNumber":pageNumber
    };
    var jsonbody = json.encode(body);
    try{
      await ApiService.getSuccessedReportHistoryPagination(jsonbody).then((success) {
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
        print("getSuccessedReportHistoryPagination data is ** "+list.toString());

        if(pageNumber == "" || pageNumber == "1"){
          successedReportHistoryModel.clear();
        }

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

  Future<bool> getSuccessedReportReportHistoryByUser({required String personId, required String groupId})async {

    successedReportHistoryByUserList.clear();
    getSuccessedReportHistoryByUserStatus = false;
    notifyListeners();

    bool status = true;

    Map body={
      'userID':personId,
      'GroupId':groupId,

    };
    var jsonbody = json.encode(body);
    try{
      await ApiService.getSuccessedReportHistoryByUser(jsonbody).then((success) {
        print("++++++++++++++++++++++++"+success.toString());
        print("***********************");
        List<dynamic> list = json.decode(success);
        print("getSuccessedReportHistoryByUser data is ** "+list.toString());
        // reportHistoryByUserList.clear();
        for(int i = 0; i < list.length; i++){
          try{
            successedReportHistoryByUserList.add(ReportHistory.fromJson(list[i]));
          }
          catch(ex){
            // rethrow;
            status = false;
            getSuccessedReportHistoryByUserStatus = false;
            notifyListeners();
            return status;
          }
        }
        status = true;
        getSuccessedReportHistoryByUserStatus = true;
        notifyListeners();
        changedataReturnStatus();
        return status;
      });
    }
    catch(ex){
      // rethrow;
      status = false;
      getSuccessedReportHistoryByUserStatus = false;
      notifyListeners();
      return status;
    }
    return status;
  }



  List<ReportHistory> get SuccessedReportHistoryModel => successedReportHistoryModel;
  bool get DataReturnStatus => dataReturnStatus;

}