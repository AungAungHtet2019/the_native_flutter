import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(
                  key: key,
                  //backgroundColor: Colors.black54,
                  backgroundColor: Colors.transparent,
                  children: <Widget>[
                    Center(
//                      child: Column(children: [
//                        CircularProgressIndicator(),
//                        SizedBox(height: 10,),
//                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
//                      ]),
                    child:  SpinKitDoubleBounce(
                        color: Colors.white),
                    )
                  ]));
        });
  }
}
