// import 'dart:async';
// import 'dart:collection';
// import 'dart:io';
// import 'dart:math' as Math;
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:the_native_flutter/view/pages/crop_monitoring/soil_population_page.dart';
//
// import '../../../utils/rest_api.dart';
// import '../../widgets/geo_server_widget.dart';
//
// class DrewPolygonPage extends StatefulWidget {
//
//   @override
//   _DrewPolygonPageState createState() => _DrewPolygonPageState();
// }
//
// class _DrewPolygonPageState extends State<DrewPolygonPage> {
//   Completer<GoogleMapController> _controller = Completer();
//
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(19.806978312132447, 96.27252819161612),
//     zoom: 14.4746,
//   );
//
//   final Set<Polygon> _polygons = HashSet<Polygon>();
//   final Set<Polyline> _polyLines = HashSet<Polyline>();
//
//   bool _drawPolygonEnabled = false;
//   List<LatLng> _userPolyLinesLatLngList = <LatLng>[];
//   bool _clearDrawing = false;
//   int _lastXCoordinate =0, _lastYCoordinate = 0;
//
//   @override
//   void dispose() async{
//     // TODO: implement dispose
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightGreenAccent,
//         title: Text("စိုက်ခင်းဧရိယာသတ်မှတ်ရန်",style: TextStyle(color: Colors.black),),
//         actions: [
//           _clearDrawing && _drawPolygonEnabled == true ? IconButton(
//               onPressed: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> GeoServerWidget(
//                   title: "စပါးစိုက်ခင်းအခြေအနေ",
//                   latLong: "19.803387373037715, 96.26350603358078",
//                   location: " ရေဆင်းအနီး ",
//                   url: riceSoilUrl,
//                   // url: 'http://20.6.128.25:8080/geoserver/CropTest/wms?service=WMS&version=1.1.0&request=GetMap&layers=CropTest%3Ageotiff_coverage&bbox=841560.0%2C2193620.0%2C843640.0%2C2197000.0&width=1893&height=915&srs=EPSG%3A32646&styles=&format=application/openlayers',
//                 )));
//               },
//               icon: Icon(Icons.send_time_extension_rounded,color: Colors.red,)): Container()
//         ],
//       ),
//
//       body: GestureDetector(
//         onPanUpdate: (_drawPolygonEnabled) ? _onPanUpdate : null,
//         onPanEnd: (_drawPolygonEnabled) ? _onPanEnd : null,
//         child: GoogleMap(
//           mapType: MapType.satellite,
//           initialCameraPosition: _kGooglePlex,
//           polygons: _polygons,
//           polylines: _polyLines,
//           onMapCreated: (GoogleMapController controller) {
//             print("GoogleMap->onMapCreated");
//             if(_controller.isCompleted){
//               print("_controller is already completed");
//             }
//             else{
//               _controller.complete(controller);
//             }
//           },
//         ),
//       ),
//
//
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: _toggleDrawing,
//         tooltip: 'Drawing',
//         child: Icon((_drawPolygonEnabled) ? Icons.cancel : Icons.edit),
//       ),
//     );
//   }
//
//   _toggleDrawing() {
//     _clearPolygons();
//     setState(() => _drawPolygonEnabled = !_drawPolygonEnabled);
//   }
//
//   _onPanUpdate(DragUpdateDetails details) async {
//
//     print("_onPanUpdate ${details.delta.dx}");
//
//     // To start draw new polygon every time.
//     if (_clearDrawing) {
//       _clearDrawing = false;
//       _clearPolygons();
//     }
//
//     if (_drawPolygonEnabled) {
//       late double x, y;
//       if (Platform.isAndroid) {
//         // It times in 3 without any meaning,
//         // We think it's an issue with GoogleMaps package.
//         x = details.globalPosition.dx * 3;
//         y = details.globalPosition.dy * 3;
//       } else if (Platform.isIOS) {
//         x = details.globalPosition.dx;
//         y = details.globalPosition.dy;
//       }
//
//       // Round the x and y.
//       int xCoordinate = x.round();
//       int yCoordinate = y.round();
//
//       // Check if the distance between last point is not too far.
//       // to prevent two fingers drawing.
//       if (_lastXCoordinate != 0 && _lastYCoordinate != 0) {
//         var distance = Math.sqrt(Math.pow(xCoordinate - _lastXCoordinate, 2) + Math.pow(yCoordinate - _lastYCoordinate, 2));
//         // Check if the distance of point and point is large.
//         if (distance > 80.0) return;
//       }
//
//       // Cached the coordinate.
//       _lastXCoordinate = xCoordinate;
//       _lastYCoordinate = yCoordinate;
//
//       ScreenCoordinate screenCoordinate = ScreenCoordinate(x: xCoordinate, y: yCoordinate);
//
//       final GoogleMapController controller = await _controller.future;
//       LatLng latLng = LatLng(0, 0);
//       try{
//         print("converting screen coordinate to lat lng");
//         print(screenCoordinate);
//
//         latLng = await controller.getLatLng(screenCoordinate);
//       }
//       catch(exp, stackTrace){
//         print("getLatLng throw exp");
//         print(exp);
//         print(stackTrace);
//       }
//       if(latLng.longitude == 0 && latLng.latitude == 0){
//         print("can't get lat lng from map");
//         return;
//       }
//
//       try {
//         // Add new point to list.
//         _userPolyLinesLatLngList.add(latLng);
//
//         _polyLines.removeWhere((polyline) => polyline.polylineId.value == 'user_polyline');
//         if(_userPolyLinesLatLngList.isNotEmpty){
//           _polyLines.add(
//             Polyline(
//               polylineId: PolylineId('user_polyline'),
//               points: _userPolyLinesLatLngList,
//               width: 2,
//               color: Colors.blue,
//             ),
//           );
//
//         }
//       } catch (e) {
//         print(" error painting $e");
//       }
//       setState(() {});
//     }
//   }
//
//   _onPanEnd(DragEndDetails details) async {
//     // Reset last cached coordinate
//     _lastXCoordinate = 0;
//     _lastYCoordinate = 0;
//
//     if (_drawPolygonEnabled) {
//       _polygons.removeWhere((polygon) => polygon.polygonId.value == 'user_polygon');
//       if(_userPolyLinesLatLngList.isNotEmpty){
//
//         _polygons.add(
//           Polygon(
//             polygonId: PolygonId('user_polygon'),
//             points: _userPolyLinesLatLngList,
//             strokeWidth: 2,
//             strokeColor: Colors.blue,
//             fillColor: Colors.blue.withOpacity(0.4),
//           ),
//         );
//       }
//       setState(() {
//         _clearDrawing = true;
//
//       });
//     }
//   }
//
//   _clearPolygons() {
//     print("_clearPolygons");
//     setState(() {
//       _polyLines.clear();
//       _polygons.clear();
//       _userPolyLinesLatLngList.clear();
//     });
//   }
// }