import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/rest_api.dart';
import '../widgets/geo_server_widget.dart';
import 'google_map/show_tile_overlay.dart';

class DrawPolygonUsingPointPage extends StatefulWidget {
  const DrawPolygonUsingPointPage({Key? key}) : super(key: key);

  @override
  State<DrawPolygonUsingPointPage> createState() => _DrawPolygonUsingPointPageState();
}

class _DrawPolygonUsingPointPageState extends State<DrawPolygonUsingPointPage> {

  final Completer<GoogleMapController> _controller = Completer();

  //Initial Location on the map
  static const kInitialLocation = CameraPosition(
    target: LatLng(19.806978312132447, 96.27252819161612),
    zoom: 14.4746,
  );

  //markers for google map
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = HashSet<Polygon>();
  final Set<Polyline> _polylines = {};
  List<LatLng> _points = [];


  bool _drawPolygonEnabled = false;
  bool _clearDrawing = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text("စိုက်ခင်းဧရိယာသတ်မှတ်ရန်",style: TextStyle(color: Colors.black),),
        actions: [
          _clearDrawing && _drawPolygonEnabled == true && _points.length > 2 ? IconButton(
              onPressed: (){

                print(_points);
                print(_points[0]);
                print(_points[3]);
                print(_points[3].longitude);




                Navigator.push(context, MaterialPageRoute(builder: (context)=> GeoServerWidget(
                  title: "စပါးစိုက်ခင်းအခြေအနေ",
                  latLong: "19.803387373037715, 96.26350603358078",
                  location: " ရေဆင်းအနီး ",
                  // url: riceSoilUrl,
                  url: "https://aungaunghtet2019.github.io/eos_crop_monitoring/"
                  // url: 'http://20.6.128.25:8080/geoserver/CropTest/wms?service=WMS&version=1.1.0&request=GetMap&layers=CropTest%3Ageotiff_coverage&bbox=841560.0%2C2193620.0%2C843640.0%2C2197000.0&width=1893&height=915&srs=EPSG%3A32646&styles=&format=application/openlayers',
                )));



                // Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowTileOverlayPage()));
                },
              icon: Icon(Icons.send_time_extension_rounded,color: Colors.red,)): Container()
        ],
      ),

      body: GoogleMap(
        mapType:  MapType.satellite,
        initialCameraPosition:  kInitialLocation,
        onMapCreated: onMapCreated,
        markers: _markers,
        compassEnabled:  false,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        polylines: _polylines,
        polygons: _polygons,
        onLongPress: (_drawPolygonEnabled) ? (latlng){
          _onTapAddMarker(latlng);
        } : null,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:_toggleDrawing,
        tooltip: 'Drawing',
        child: Icon((_drawPolygonEnabled) ? Icons.cancel : Icons.edit),
      ),

    );
  }

  void onMapCreated(GoogleMapController controller)async{
    _controller.complete(controller);
  }

  void _onTapAddMarker(LatLng latlang)async{

    setState(() {
      _drawPolygonEnabled = true;
      _clearDrawing = true;

      _markers.add(
        Marker(
          markerId: MarkerId(DateTime.now().toString()),
          position: latlang,
          infoWindow: InfoWindow(title: (_points.length+1).toString(),snippet: '5 Star Rating'),
          icon: BitmapDescriptor.defaultMarker,

          //on tap to remove a marker
          onTap: (){

          }),
      );
      _points.add(latlang);
      updatePolygons();
    });
  }

  updatePolygons(){
    _polylines.add(
      Polyline(
          polylineId:  PolylineId('1'),
        points: _points,
        color: Colors.orangeAccent
      )
    );

    _polygons.add(
      Polygon(
          polygonId: PolygonId('1'),
        points: _points,
        fillColor: Colors.red.withOpacity(0.3),
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.orangeAccent,

      )
    );
  }

  _toggleDrawing() {
    _clearPolygons();
    setState(() {
      _drawPolygonEnabled = !_drawPolygonEnabled;
      _clearDrawing = !_clearDrawing;
    });
  }

  _clearPolygons() {
    print("_clearPolygons");
    setState(() {
      _markers.clear();
      _polylines.clear();
      _polygons.clear();
      _points.clear();
    });
  }
}
