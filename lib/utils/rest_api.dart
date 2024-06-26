import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'global.dart';

String token =  "wgpEdUEp3eb8mkzBOljXP71OenzlIeEm8NW2hDtV5FC9-sPyVb8cUYyWos6DXprW";

// final String apiEndpointNews = 'https://nnews.myanmarewg-ct.org/wp-json/wp/v2/posts?_embed';//https://mminfo.myanmarewg-ct.org/wp-json/wp/v2/posts?_embed
// final String apiEndpointNews = 'https://mminfo.myanmarewg-ct.org/wp-json/wp/v2/posts?_embed';//https://mminfo.myanmarewg-ct.org/wp-json/wp/v2/posts?_embed
// final String apiEndpointNews = 'https://nnews.myanmarewg-ct.org/wp-json/wp/v2/posts?_embed';
// final String apiEndpointNews = 'https://dynamic.zartimyay.org/wp-json/wp/v2/posts?_embed';
final String apiEndpointNews = 'https://dynamic.zartimyay.org/?rest_route=/wp/v2/posts&_embed';

// final String apiEndpointNews = 'https://www.gandawin.net//wp-json/wp/v2/posts?_embed';
// final String apiEndpointNews = 'https://mminfo.myanmarewg-ct.org/wp-json/buddypress/v1/activity';

final String suagrcaneUrl = "http://20.6.128.25/sugarcane.aspx";
final String peanutsUrl = "http://20.6.128.25/peanuts.aspx";
final String riceUrl = "http://20.6.128.25/rice.aspx";

// final String suagrcaneSoilUrl = "https://20.6.128.25:8443/geoserver/SugarCane_NDVI05May/wms?service=WMS&version=1.1.0&request=GetMap&layers=SugarCane_NDVI05May%3ASugarCane_Field_NDVI_02May2022&bbox=842790.0%2C2175780.0%2C844290.0%2C2178600.0&width=408&height=768&srs=EPSG%3A32646&styles=&format=application/openlayers";
// final String peanutsSoilUrl = "https://20.6.128.25:8443/geoserver/Peanuts_NDVI05May/wms?service=WMS&version=1.1.0&request=GetMap&layers=Peanuts_NDVI05May%3APeanut_NDVI_05May2022&bbox=833530.0%2C2208370.0%2C833920.0%2C2208780.0&width=730&height=768&srs=EPSG%3A32646&styles=&format=application/openlayers#toggle";
// // final String riceSoilUrl = "https://20.6.128.25:8443/geoserver/Rice_NDVI05May/wms?service=WMS&version=1.1.0&request=GetMap&layers=Rice_NDVI05May%3ARice_NDVI_07May2022&bbox=841560.0%2C2193620.0%2C843640.0%2C2197000.0&width=472&height=768&srs=EPSG%3A32646&styles=&format=application/openlayers";
// final String riceSoilUrl = "https://20.6.128.25:8443/geoserver/Rice_NDVI05May/wms?service=WMS&version=1.1.0&request=GetMap&layers=Rice_NDVI05May%3ARice_NDVI_07May2022&bbox=841560.0%2C2193620.0%2C843640.0%2C2197000.0&width=1870&height=940&srs=EPSG%3A32646&styles=&format=application/openlayers";


final String suagrcaneSoilUrl = "https://cms.zartimyay.org/SugarCane.aspx";
final String peanutsSoilUrl = "https://cms.zartimyay.org/Peanuts.aspx";
// final String riceSoilUrl = "https://20.6.128.25:8443/geoserver/Rice_NDVI05May/wms?service=WMS&version=1.1.0&request=GetMap&layers=Rice_NDVI05May%3ARice_NDVI_07May2022&bbox=841560.0%2C2193620.0%2C843640.0%2C2197000.0&width=472&height=768&srs=EPSG%3A32646&styles=&format=application/openlayers";
final String riceSoilUrl = "https://cms.zartimyay.org/Rice.aspx";




class URLS {

  // static const String domain = "http://192.168.4.91:82";
  // static const String domain = "http://dsitdteam-001-site1.atempurl.com";
  // static const String domain = "http://kothiha-001-site2.atempurl.com";
  // static const String domain = "http://api.zartimyay.org";




  // static const String ktkkdomain = "http://kothiha-001-site1.atempurl.com";

  // static const String orders = 'http://192.168.1.10:8090/api/orders';

  static const String smsPoh = "https://smspoh.com/api/v2/send";

  static const String login_user_URL =domain+'/api/Authenticate/login';
  static const String refresh_token_URL =domain+'/api/Authenticate/refresh-token';
  static const String  check_user_URL =domain+'/api/User/check_user';
  static const String register_URL =domain+'/api/User/register';

  // static const String sendMemberCode_URL =ktkkdomain+'/api/ClientMemberReq';
  static const String sendMemberCode_URL =domain+'/api/User/member_request';

  // static const String getMemberList_URL =ktkkdomain+'/api/SearchingMemListClient';
  static const String getMemberList_URL =domain+'/api/User/SearchMemberList';


  static const String updateProfilePicture_URL =domain+'/api/User/updateProfilePicture';
  static const String uploadUserProfilePicture_URL =domain+'/api/User/user_profile_picture_upload';

  static const String getCategory_URL =domain+'/api/User/get_category';
  static const String getLikedCategory_URL =domain+'/api/User/get_like_category';
  static const String add_my_category_URL =domain+'/api/User/add_my_category';
  static const String delete_my_category_URL =domain+'/api/User/delete_my_category';
  static const String send_SMS_OTP_URL =domain+' ';

  static const String report_form_URL =domain+'/api/User/report_form';
  static const String milti_file_uploat_URL =domain+'/api/User/multi_file_upload';
  static const String get_report_history_URL =domain+'/api/User/get_report_history';
  static const String get_report_history_Pagination_URL =domain+'/api/Report/get_report_history_pagination';
  static const String get_report_history_by_user_URL =domain+'/api/Report/get_report_history_by_user';

  // static const String get_case_file_list_URL =domain+'/api/User/search_case_file_list';
  static const String create_Reply_URL =domain+'/api/User/create_reply';
  static const String reply_file_uploat_URL =domain+'/api/User/reply_file_upload';
  static const String close_case_file_URL =domain+'/api/User/close_case_file';
  static const String get_successed_report_history_URL =domain+'/api/User/get_successed_report_history';
  static const String get_successed_report_history_Pagination_URL =domain+'/api/Report/get_successed_report_history_pagination';
  static const String get_successed_report_history_by_user_URL =domain+'/api/Report/get_successed_report_history_by_user';



  static const String insertLatLong_url = domain+"/api/Map/set_latlong";


}




class ApiService {

  static Future<String> LoginUser(body)async{
    print("This is LoginUser Method");
    print("body of LoginUser is "+body);

    http.Response r = await http.post(Uri.parse(URLS.login_user_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code LoginUser is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else if(r.statusCode ==401){
      return r.statusCode.toString();
    }
    else {
      return "Error";
    }
  }

  static Future<String> RefreshToken(body)async{
    print("This is RefreshToken Method");
    print("body of RefreshToken is "+body);

    http.Response r = await http.post(Uri.parse(URLS.refresh_token_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code RefreshToken is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else if(r.statusCode == 401){
      return r.statusCode.toString();
    }
    else{
      return r.statusCode.toString();
    }
  }


  static Future<String> CheckUser(body,token)async{
    print("This is CheckUser Method");
    print("body of CheckUser is "+body);

    http.Response r = await http.post(Uri.parse(URLS.check_user_URL),headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    },body: body);
    print("Status code CheckUser is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else if(r.statusCode == 401){
      return r.statusCode.toString();
    }
    else{
      return r.body.toString();
    }
  }

  static Future<String> InsertUser(body)async{

    print("This is register Method");
    print("body of register is "+body);

    http.Response r = await http.post(Uri.parse(URLS.register_URL),headers: {
      "Content-Type": "application/json",
    },body: body);
    print("Status code register is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String>sendMemberCode(String Member_Code, String Customer_ID) async {

    Map<String, dynamic>    formMap = {
      "Status": "IN",
      "Member_Code": Member_Code,
      "Customer_ID": Customer_ID,
    } ;

    print("formMap is "+formMap.toString());

    http.Response    response = await http.post(
      Uri.parse(URLS.sendMemberCode_URL),
      body: convert.jsonEncode(formMap),
      // body:formMap,
      headers: {
        // "Content-Type": "application/x-www-form-urlencoded"
        "Content-Type": "application/json"
      },
      // encoding: convert.Encoding.getByName("utf-8"),
    );
    print("RESPONSE ${response.statusCode} ; BODY = ${response.body}");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (response.body) ;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return (response.body) ;
    }
  }

  static Future<String>getMemberList(String Customer_ID) async {

    Map<String, dynamic>    formMap = {
      "Client_ID": Customer_ID,
    } ;

    print("getMemberList formMap is "+formMap.toString());

    http.Response    response = await http.post(
      Uri.parse(URLS.getMemberList_URL),
      body: convert.jsonEncode(formMap),
      // body:formMap,
      headers: {
        // "Content-Type": "application/x-www-form-urlencoded"
        "Content-Type": "application/json"
      },
      // encoding: convert.Encoding.getByName("utf-8"),
    );
    print("RESPONSE ${response.statusCode} ; BODY = ${response.body}");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (response.body) ;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return (response.body) ;
    }
  }

  static Future<String> updateProfilePicture(body)async{

    print("This is updateProfilePicture Method");
    print("body of updateProfilePicture is "+body);

    http.Response r = await http.post(Uri.parse(URLS.updateProfilePicture_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code register is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> uploadUserProfilePicture(body)async{
    print("This is uploadUserProfilePicture Method");
    print("body of uploadUserProfilePicture is "+body);

    http.Response r = await http.post(Uri.parse(URLS.uploadUserProfilePicture_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code uploadUserProfilePicture is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }


  static Future<String>getCategory() async {
    http.Response    response = await http.get(
      Uri.parse(URLS.getCategory_URL),
    );
    print("RESPONSE ${response.statusCode} ; BODY = ${response.body}");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (response.body) ;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return (response.body) ;
    }
  }

  static Future<String>getLikedCategory(body) async {
    print("This is getLikedCategory Method");
    print("body of getLikedCategory is "+body);

    http.Response r = await http.post(Uri.parse(URLS.getLikedCategory_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code getLikedCategory is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> addLikedCategory(body)async{

    print("This is addLikedCategory Method");
    print("body of addLikedCategory is "+body);

    http.Response r = await http.post(Uri.parse(URLS.add_my_category_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code addLikedCategory is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> deleteLikedCategory(body)async{

    print("This is deleteLikedCategory Method");
    print("body of deleteLikedCategory is "+body);

    http.Response r = await http.post(Uri.parse(URLS.delete_my_category_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code deleteLikedCategory is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }
  static Future<String> sendSMSOTP(body)async{

    print("This is sendSMSOTP Method");
    print("body of sendSMSOTP is "+body);

    http.Response r = await http.post(Uri.parse(URLS.send_SMS_OTP_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code sendSMSOTP is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> reportForm(body)async{
    print("This is reportForm Method");
    print("body of reportForm is "+body);

    http.Response r = await http.post(Uri.parse(URLS.report_form_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code reportForm is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> multiFileUpload(body)async{
    print("This is multiFileUpload Method");
    print("body of multiFileUpload is "+body);

    http.Response r = await http.post(Uri.parse(URLS.milti_file_uploat_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code multiFileUpload is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> getReportHistory(body)async{
    print("This is getReportHistory Method");
    print("body of getReportHistory is "+body);

    http.Response r = await http.post(Uri.parse(URLS.get_report_history_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code getReportHistory is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> getReportHistoryPagination(body)async{
    print("This is getReportHistoryPagination Method");
    print("body of getReportHistoryPagination is "+body);

    http.Response r = await http.post(Uri.parse(URLS.get_report_history_Pagination_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code getReportHistoryPagination is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> getReportHistoryByUser(body)async{
    print("This is getReportHistoryByUser Method");
    print("body of getReportHistoryByUser is "+body);

    http.Response r = await http.post(Uri.parse(URLS.get_report_history_by_user_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code getReportHistoryByUser is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }


  // static Future<String> getCaseFileList(body)async{
  //   print("This is getCaseFileList Method");
  //   print("body of getCaseFileList is "+body);
  //
  //   http.Response r = await http.post(Uri.parse(URLS.get_case_file_list_URL),headers: {"Content-Type": "application/json"},body: body);
  //   print("Status code getCaseFileList is "+r.statusCode.toString());
  //   print("r.body is "+r.body.toString());
  //   if(r.statusCode ==200){
  //     return r.body.toString();
  //   }
  //   else{
  //     return "Error";
  //   }
  // }

  static Future<String> createCaseReply(body)async{
    print("This is createCaseReply Method");
    print("body of createCaseReply is "+body);

    http.Response r = await http.post(Uri.parse(URLS.create_Reply_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code createCaseReply is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> replyFileUpload(body)async{
    print("This is replyFileUpload Method");
    print("body of replyFileUpload is "+body);

    http.Response r = await http.post(Uri.parse(URLS.reply_file_uploat_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code replyFileUpload is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> closeCaseFile(body)async{
    print("This is closeCaseFile Method");
    print("body of closeCaseFile is "+body);

    http.Response r = await http.post(Uri.parse(URLS.close_case_file_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code closeCaseFile is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> getSuccessedReportHistory(body)async{
    print("This is getSuccessedReportHistory Method");
    print("body of getSuccessedReportHistory is "+body);

    http.Response r = await http.post(Uri.parse(URLS.get_successed_report_history_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code getSuccessedReportHistory is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> getSuccessedReportHistoryPagination(body)async{
    print("This is getSuccessedReportHistoryPagination Method");
    print("body of getSuccessedReportHistoryPagination is "+body);

    http.Response r = await http.post(Uri.parse(URLS.get_successed_report_history_Pagination_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code getSuccessedReportHistoryPagination is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }

  static Future<String> getSuccessedReportHistoryByUser(body)async{
    print("This is getSuccessedReportHistoryByUser Method");
    print("body of getSuccessedReportHistoryByUSer is "+body);

    http.Response r = await http.post(Uri.parse(URLS.get_successed_report_history_by_user_URL),headers: {"Content-Type": "application/json"},body: body);
    print("Status code getSuccessedReportHistoryByUser is "+r.statusCode.toString());
    print("r.body is "+r.body.toString());
    if(r.statusCode ==200){
      return r.body.toString();
    }
    else{
      return "Error";
    }
  }


  static Future<String> insertTaskID_LatLong(body)async{
    print(body);
    http.Response r = await http.post(Uri.parse(URLS.insertLatLong_url),headers: {"Content-Type": "application/json"},body: body);
    print("insertTaskID_LatLong data is "+r.body);
    return r.body;
  }

}