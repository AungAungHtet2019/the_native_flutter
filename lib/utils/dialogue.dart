import 'package:flutter/cupertino.dart';
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
              onWillPop: () async => false,
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

  static Future<void> myDialog(BuildContext context,String title) {
    // flutter defined function
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("Zartimyay "),
          content: Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: new Text(title),
          ),
          actions: <Widget>[
            // CupertinoDialogAction(
            //   isDefaultAction: true,
            //   child: Text("This phone number is already registered",style: TextStyle(color: Colors.red,fontSize: 12.0)),
            // ),
            new TextButton (
              child: new Text("OK"),
              onPressed: () {
                Navigator.pop(context);

              },
            )
          ],
        );
      },
    );
  }

}
