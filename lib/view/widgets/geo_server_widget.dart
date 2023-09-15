import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../components/custom_alert_dialogbox.dart';
import '../../components/index_alert_dialogbox.dart';
import '../../provider/crop_monitioring_provider.dart';



class GeoServerWidget extends StatefulWidget {

  String title;
  String latLong;
  String location;
  String url;
  GeoServerWidget({Key? key,required this.title,required this.latLong,required this.location,required this.url}) : super(key: key);


  @override
  State<GeoServerWidget> createState() => _GeoServerWidgetState();
}

class _GeoServerWidgetState extends State<GeoServerWidget> {

  var loadingPercentage = 0;
  // late final WebViewController controller;
  final Completer<WebViewController> controller =
  Completer<WebViewController>();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        // Uri.parse('https://www.meteoblue.com/en/weather/maps/widget/city-of-coppell_united-states_7173229?windAnimation=0&windAnimation=1&gust=0&gust=1&satellite=0&satellite=1&cloudsAndPrecipitation=0&cloudsAndPrecipitation=1&temperature=0&temperature=1&sunshine=0&sunshine=1&extremeForecastIndex=0&extremeForecastIndex=1&geoloc=fixed&tempunit=C&windunit=km%252Fh&lengthunit=metric&zoom=5&autowidth=auto#coords=5/32.96/-96.99&map=windAnimation~rainbow~auto~10%20m%20above%20gnd~none'),
        //Uri.parse('https://flutter.dev'),
        // Uri.parse('http://20.6.128.25:8080/geoserver/Mytesting/wms?service=WMS&version=1.1.0&request=GetMap&layers=Mytesting%3Aphh2o_30-60cm_Q0.5&bbox=-179.998%2C-55.9773%2C179.994%2C82.7193&width=1893&height=915&srs=EPSG%3A4326&styles=&format=application/openlayers#toggle'),
        // Uri.parse('http://20.6.128.25:8080/geoserver/CropTest/wms?service=WMS&version=1.1.0&request=GetMap&layers=CropTest%3Ageotiff_coverage&bbox=841560.0%2C2193620.0%2C843640.0%2C2197000.0&width=1893&height=915&srs=EPSG%3A32646&styles=&format=application/openlayers'),
        Uri.parse(widget.url),
        // Uri.parse("https://20.6.128.25/sugarcane.aspx"),
      );


     */

  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
      ),
      body: Stack(
        children: [
          /*
          WebView(
            // controller: controller,
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              controller.complete(webViewController);
            },
          ),

           */


          InAppWebView(
            initialUrlRequest: URLRequest(
                url: Uri.parse(widget.url)
            ),
            onReceivedServerTrustAuthRequest: (controller, challenge) async {
              print(challenge);
              return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
            },
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),

          // Text("Loading $loadingPercentage")
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //     showDialog(context: context,
      //         builder: (BuildContext context){
      //           return CustomDialogBox(
      //             title: "အကြံပြုချက်",
      //             latlong: widget.latLong,
      //             location: widget.location,
      //             descriptions: "ပျိုးပင်မရှိသည့်မြေများတွင်စိုက်ပျိုးရေးများလုပ်ဆောင်သင့်ပါသည်။ဖွံ့ဖြိုးမှုကျဆင်းနေသောပျိုးပင်များအားဓာတ်မြေသြဇာအသုံးပြုခြင်း၊ပေါင်းပင်များရှင်းလင်းသင့်ပါသည်။ဖွံ့ဖြိုးမှုအသင့်အတင့်ရှိသောပျိုးပင်များကိုစိုက်ပျိုးရေးနည်းစနစ်များအတိုင်းဆက်လက်လုပ်ဆောင်သင့်ပါသည်။",
      //             text: "အိုကေ",
      //           );
      //         }
      //     );
      //   },
      //   label: const Text('AI Result'),
      //   // icon: const Icon(Icons.thumb_up),
      //   backgroundColor: Colors.lightGreen,
      // ),
      floatingActionButton: SpeedDial(
        child: Icon(Icons.email),
        closedForegroundColor: Colors.orange,
        openForegroundColor: Colors.white,
        closedBackgroundColor: Colors.white,
        openBackgroundColor: Colors.red,
        // labelsStyle: /* Your label TextStyle goes here */,
        labelsBackgroundColor: Colors.white,
        // controller: /* Your custom animation controller goes here */,
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: Icon(Icons.task_rounded),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            label: 'AI Result',
            onPressed: () {
                  showDialog(context: context,
                      builder: (BuildContext context){
                        return CustomDialogBox(
                          title: "အကြံပြုချက်",
                          latlong: widget.latLong,
                          location: widget.location,
                          descriptions: "ပျိုးပင်မရှိသည့်မြေများတွင်စိုက်ပျိုးရေးများလုပ်ဆောင်သင့်ပါသည်။ဖွံ့ဖြိုးမှုကျဆင်းနေသောပျိုးပင်များအားဓာတ်မြေဩဇာအသုံးပြုခြင်း၊ပေါင်းပင်များရှင်းလင်းသင့်ပါသည်။ဖွံ့ဖြိုးမှုအသင့်အတင့်ရှိသောပျိုးပင်များကိုစိုက်ပျိုးရေးနည်းစနစ်များအတိုင်းဆက်လက်လုပ်ဆောင်သင့်ပါသည်။",
                          text: "အိုကေ",
                        );
                      }
                  );
            },
            closeSpeedDialOnPressed: false,
          ),
          SpeedDialChild(
            child: Icon(Icons.trending_up),
            foregroundColor: Colors.black,
            backgroundColor: Colors.yellow,
            label: "ရည်ညွှန်းချက်",
            onPressed: () {
              showDialog(context: context,
                  builder: (BuildContext context){
                    return IndexDialogBox(
                      title: "ရည်ညွှန်းချက်",
                      text: "အိုကေ",
                    );
                  }
              );
            },
            closeSpeedDialOnPressed: false,
          ),
          //  Your other SpeedDialChildren go here.
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }
}
