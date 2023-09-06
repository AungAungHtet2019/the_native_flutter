import 'dart:async';
import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../provider/crop_monitioring_provider.dart';
import '../../../provider/user_provider.dart';
import '../../../utils/rest_api.dart';
import '../../widgets/geo_server_widget.dart';
import '../google_map/show_tile_overlay.dart';

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
  List myArrayList = [];

  late Future _getCurrentLocationFuture;
  LatLng? _currentPosition;

  bool _drawPolygonEnabled = false;
  bool _clearDrawing = false;

  bool mapStatus = false;
  bool loadingStatus = false;


  getResult(List latLongArrayList)async{
    print("hello getResult");
    String userID = Provider.of<UserProvider>(context,listen: false).userModel.UserID;



    mapStatus= await Provider.of<CropMonitoringProvider>(context,listen: false).requestSearchScence(latLongArrayList,userID);
    print(mapStatus);
    if(mapStatus == true){
      String taskId = await Provider.of<CropMonitoringProvider>(context,listen: false).taskId;
      setState(() {
        loadingStatus = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=> GeoServerWidget(
          title: "စပါးစိုက်ခင်းအခြေအနေ",
          latLong: "19.803387373037715, 96.26350603358078",
          location: " ရေဆင်းအနီး ",
          // url: "https://aungaunghtet2019.github.io/eos_crop_monitoring/"
          url:"https://rrms.zartimyay.org/map?task="+taskId
      )));
      myArrayList.clear();

    }
    else{
      setState(() {
        loadingStatus = false;
      });
      cropMonitoringErrorDialogBox(Provider.of<CropMonitoringProvider>(context,listen: false).result);
    }

    ///ဒုဌာနမှူးအတွက်ပြင်ထားတာ
    /*
    Navigator.push(context, MaterialPageRoute(builder: (context)=> GeoServerWidget(
        title: "စိုက်ခင်းအခြေအနေ",
        latLong: "19.803387373037715, 96.26350603358078",
        location: " ရေဆင်းအနီး ",
        // url: "https://aungaunghtet2019.github.io/eos_crop_monitoring/"
        url:"https://rrms.zartimyay.org/ground_overlay.html"
    )));
     */
    ///


  }

  _getCurrentLocation() async {

    Position? position;

    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true,
          timeLimit: Duration(seconds: 15));
    } catch (e) {
      position = null;
      print("ho");
      debugPrint(e.toString());
      print("he");

    }

    if (position != null) {
      LatLng location = LatLng(position.latitude, position.longitude);
      _currentPosition = location;
      print("Hello");
      print(_currentPosition);
      print("Hi");

    }

    return true;
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }


  @override
  void initState() {
    // TODO: implement initState
    _getCurrentLocationFuture = _getCurrentLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text("စိုက်ခင်းဧရိယာသတ်မှတ်ရန်",style: TextStyle(color: Colors.black),),
        actions: [
          _clearDrawing && _drawPolygonEnabled == true && _points.length > 2 ? IconButton(
              onPressed: (){

                setState(() {
                  loadingStatus = true;
                });
                print(_points);
                print(_points[0]);
                print(_points[3]);
                print(_points[3].longitude);




                _points.forEach((element) {
                  myArrayList.add([element.longitude,element.latitude]);
                });
                myArrayList.add(myArrayList[0]);
                print("Hey");
                print(myArrayList);
                print(myArrayList[0][0]);



                ///ဒုဌာနမှူးအတွက်ပြင်ထားတာ
                /*
                myArrayList = [
                  [-86.86718,41.317464],
                  [-86.86718,41.331596],
                  [-86.862631,41.331596],
                  [-86.862631,41.317464],
                  [-86.86718,41.317464]
                ];
                print("Hey");
                print(myArrayList);
                print(myArrayList[0][0]);


                 */

                ///
                getResult(myArrayList);


                // Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowTileOverlayPage()));
                },
              icon: Icon(Icons.send_time_extension_rounded,color: Colors.red,)): Container()
        ],
      ),

      body:loadingStatus == false ? GoogleMap(
        mapType:  MapType.satellite,
        initialCameraPosition:  CameraPosition(
           target: _currentPosition ?? LatLng(19.806978312132447, 96.27252819161612),

          ///ဒုဌာနမှူးအတွက်ပြင်ထားတာ
          //target: _currentPosition ?? LatLng(41.331596, -86.862631),
          ///
          zoom: 14.4746,
        ),
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
      ):
      Stack(
        children: [
          GoogleMap(
            mapType:  MapType.satellite,
            initialCameraPosition:  CameraPosition(
              target: _points.length  != 0 ? LatLng(myArrayList[0][1], myArrayList[0][0]) : _currentPosition ?? LatLng(19.806978312132447, 96.27252819161612),
              zoom: 14.4746,
            ),
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
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:_toggleDrawing,
        tooltip: 'Drawing',
        child: Icon((_drawPolygonEnabled) ? Icons.cancel : Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

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

  //cropMonitoringErrorDialogBox
  void cropMonitoringErrorDialogBox(String result) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("The Native "),
          content: Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: new Text(result),
          ),
          actions: <Widget>[
            // CupertinoDialogAction(
            //   isDefaultAction: true,
            //   child: Text("This phone number is already registered",style: TextStyle(color: Colors.red,fontSize: 12.0)),
            // ),
            new TextButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> GeoServerWidget(
                    title: "စိုက်ခင်းအခြေအနေ",
                    latLong: "19.803387373037715, 96.26350603358078",
                    location: " ရေဆင်းအနီး ",
                    url: "https://aungaunghtet2019.github.io/eos_crop_monitoring/"
                )));
                myArrayList.clear();

              },
            ),
          ],
        );
      },
    );
  }
}
