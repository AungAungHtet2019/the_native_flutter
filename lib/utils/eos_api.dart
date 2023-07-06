import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

 const String api_key ="apk.2e2a0e2e1a2bfd9eb8a336266139b78fa3f4904fa9e54e54b7682627c45f7c4c";

class URLs{
  static const String request_search_scene_for_sentinel_2_url = "https://gate.eos.com/api/lms/search/v2/sentinel2?api_key="+api_key;
  static const String download_visual_url = "https://gate.eos.com/api/gdw/api?api_key="+api_key;



}

class ApiServices{

  static Future<String> requestSearchSceneForSentinel_2(body)async{

    print("What the fuck");
    print("requestSearchSceneForSentinel_2");
    print(body);
    http.Response r = await http.post(Uri.parse(URLs.request_search_scene_for_sentinel_2_url),headers: {"Content-Type": "application/json"},body: body);

    print("Status code requestSearchSceneForSentinel_2 is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body;
    }
    else if(r.statusCode ==401){
      return r.statusCode.toString();
    }
    else {
      return "Error";
    }
  }

  static Future<String> downloadVisual(body)async{
    print(body);
    http.Response r = await http.post(Uri.parse(URLs.download_visual_url),headers: {"Content-Type": "application/json"},body: body);

    print("Status code downloadVisual is "+r.statusCode.toString());
    print("downloadVisual r.body is "+r.body.toString());
    return r.body;

  }


}