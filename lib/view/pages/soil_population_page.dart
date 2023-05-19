import 'package:flutter/material.dart';
import 'package:the_native_flutter/utils/rest_api.dart';

import '../widgets/geo_server_widget.dart';
import '../widgets/weather_widget.dart';

class SoilPopulationPage extends StatefulWidget {
  const SoilPopulationPage({Key? key}) : super(key: key);

  @override
  State<SoilPopulationPage> createState() => _SoilPopulationPageState();
}

class _SoilPopulationPageState extends State<SoilPopulationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          title: Text("Soil Population Monitoring System",style: TextStyle(color: Colors.black),),
        ),
        body:ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28.0,right:28.0,top: 8.0,bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  gradient: LinearGradient(
                    colors: [
                      // Colors.yellow,
                      // Colors.orangeAccent,
                      // Colors.yellow.shade300,
                      Colors.green,
                      Colors.lightGreenAccent,
                      Colors.lightGreen,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: Center(child: Text("ကြံ",style: TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> GeoServerWidget(
                      title: "ကြံ",
                      latLong: "19.66910973155886, 96.2860881454839",
                      location: " အဝေရာဆည်အနီး ",
                      url: suagrcaneSoilUrl,
                      // url: 'http://20.6.128.25:8080/geoserver/CropTest/wms?service=WMS&version=1.1.0&request=GetMap&layers=CropTest%3Ageotiff_coverage&bbox=841560.0%2C2193620.0%2C843640.0%2C2197000.0&width=1893&height=915&srs=EPSG%3A32646&styles=&format=application/openlayers',
                    )));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0,right: 28.0,bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green,
                      Colors.lightGreenAccent,
                      Colors.lightGreen,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: Center(child: Text("ပဲ",style: TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> GeoServerWidget(
                      title: "ပဲ",
                      latLong: "19.9498493388524, 96.18230117882081",
                      location: " ရဲတပ်ရင်း (၂၀) အနီး ",
                      url: peanutsSoilUrl,
                      // url: 'http://20.6.128.25:8080/geoserver/CropTest/wms?service=WMS&version=1.1.0&request=GetMap&layers=CropTest%3Ageotiff_coverage&bbox=841560.0%2C2193620.0%2C843640.0%2C2197000.0&width=1893&height=915&srs=EPSG%3A32646&styles=&format=application/openlayers',
                    )));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0,right: 28.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  gradient: LinearGradient(
                    colors: [
                      // Colors.orangeAccent,
                      // Colors.red,
                      // Colors.orange,
                      Colors.green,
                      Colors.lightGreenAccent,
                      Colors.lightGreen,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: Center(child: Text("ဆန်စပါး",style: TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> GeoServerWidget(
                      title: "ဆန်စပါး",
                      latLong: "19.803387373037715, 96.26350603358078",
                      location: " ရေဆင်းအနီး ",
                      url: riceSoilUrl,
                      // url: 'http://20.6.128.25:8080/geoserver/CropTest/wms?service=WMS&version=1.1.0&request=GetMap&layers=CropTest%3Ageotiff_coverage&bbox=841560.0%2C2193620.0%2C843640.0%2C2197000.0&width=1893&height=915&srs=EPSG%3A32646&styles=&format=application/openlayers',
                    )));
                  },
                ),
              ),
            ),
          ],
        )
    );
  }
}
