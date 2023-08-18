import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class WeatherPage extends StatefulWidget {

  String title;
  String url;
  WeatherPage({Key? key,required this.title,required this.url}) : super(key: key);


  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

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
          WebView(
            // controller: controller,
            initialUrl: 'https://flutter.dev',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              controller.complete(webViewController);
            },
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),

          // Text("Loading $loadingPercentage")
        ],
      ),

    );
  }
}
