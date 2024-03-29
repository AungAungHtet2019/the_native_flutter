import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'global.dart';

 const String api_key ="apk.2e2a0e2e1a2bfd9eb8a336266139b78fa3f4904fa9e54e54b7682627c45f7c4c";

class URLs{
  static const String request_search_scene_for_sentinel_2_url = "https://gate.eos.com/api/lms/search/v2/sentinel2?api_key="+api_key;
  static const String download_visual_url = "https://gate.eos.com/api/gdw/api?api_key="+api_key;
  static const String download_image_url = "https://gate.eos.com/api/gdw/api/";

  static const String create_multi_temporal_statistics_url = "https://gate.eos.com/api/gdw/api?api_key="+api_key;
  static const String get_multi_temporal_statistics_url = "https://gate.eos.com/api/gdw/api/";



  static const String getEosAnalysisImageList_url = domain+"/api/Map/get_user_analysis_map_history";
  static const String getMapPolygonPoints_url = domain+"/api/Map/get_polygon_points";
  static const String getCropMonitoringIndex_url = domain+"/api/Map/get_crop_monitoring_index";


}

class EosApiServices{

  static Future<String> requestSearchSceneForSentinel_2(body)async{

    print("What the fuck");
    print("requestSearchSceneForSentinel_2");
    print(body);
    http.Response r = await http.post(Uri.parse(URLs.request_search_scene_for_sentinel_2_url),headers: {"Content-Type": "application/json"},body: body);

    print("Status code requestSearchSceneForSentinel_2 is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    return r.body;
    /*
    if(r.statusCode ==200){
      return r.body;
    }
    else if(r.statusCode ==401){
      return r.statusCode.toString();
    }
    else {
      return "Error";
    }

     */
  }

  static Future<String> downloadVisual(body)async{
    print(body);
    http.Response r = await http.post(Uri.parse(URLs.download_visual_url),headers: {"Content-Type": "application/json"},body: body);

    print("Status code downloadVisual is "+r.statusCode.toString());
    print("downloadVisual r.body is "+r.body.toString());
    return r.body;

  }

  static Future<String> downloadImage(taskId)async{
    print(taskId);
    http.Response r = await http.get(Uri.parse(URLs.download_image_url+taskId+"?api_key="+api_key));
    print("Status code downloadImage is "+r.statusCode.toString());
    print("downloadImage r.body is "+r.body.toString());
    return r.body;
  }

  static Future<String> createMultiTemporalStatistics(body)async{

    print("createMultiTemporalStatistics");
    print(body);
    http.Response r = await http.post(Uri.parse(URLs.create_multi_temporal_statistics_url),headers: {"Content-Type": "application/json"},body: body);

    print("Status code createMultiTemporalStatistics is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    return r.body;
  }

  static Future<String> getMultiTemporalStatistics(taskId)async{
    print(taskId);
    http.Response r = await http.get(Uri.parse(URLs.get_multi_temporal_statistics_url+taskId+"?api_key="+api_key));
    print("Status code getMultiTemporalStatistics is "+r.statusCode.toString());
    print("getMultiTemporalStatistics r.body is "+r.body.toString());
    return r.body;
  }


  static Future<String> getEosAnalysedImageHistory(body)async{
    print("This is getEosAnalysedImageHistory Method");
    print("body of getEosAnalysedImageHistory is "+body);

    http.Response r = await http.post(Uri.parse(URLs.getEosAnalysisImageList_url),headers: {"Content-Type": "application/json"},body: body);
    print("Status code getEosAnalysedImageHistory is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    return r.body.toString();

  }

  static Future<String> getMapPolygonPoints(body)async{
    print("This is getMapPolygonPoints Method");
    print("body of getMapPolygonPoints is "+body);

    http.Response r = await http.post(Uri.parse(URLs.getMapPolygonPoints_url),headers: {"Content-Type": "application/json"},body: body);
    print("Status code getMapPolygonPoints is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    return r.body.toString();

  }

  static Future<String> getCropMonitoringIndex()async{
    print("This is getCropMonitoringIndex Method");

    http.Response r = await http.get(Uri.parse(URLs.getCropMonitoringIndex_url),headers: {"Content-Type": "application/json"});
    print("Status code getCropMonitoringIndex is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    return r.body.toString();

  }





}