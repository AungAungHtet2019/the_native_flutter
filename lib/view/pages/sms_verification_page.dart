import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:the_native_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;
import 'package:the_native_flutter/view/pages/registeration_page.dart';

class SmsVerificationPage extends StatefulWidget {
  // const SmsVerificationPage({Key? key}) : super(key: key);

  String phoneNumber, randomnum,signature;
  SmsVerificationPage(this.phoneNumber,this.randomnum,this.signature);

  @override
  State<SmsVerificationPage> createState() => _SmsVerificationPageState();
}

class _SmsVerificationPageState extends State<SmsVerificationPage>
    with SingleTickerProviderStateMixin {

  TextEditingController _pincodeController = TextEditingController();
  AnimationController? _animationController;
  int levelClock = 2 * 60;




  sendOTPSMS(String phoneNumber)async{

    HttpClient client = new HttpClient(); //SSL Certificate အတွက်သုံးထားတာဖြစ်တယ်
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    int min = 1000; //min and max values act as your 6 digit range
    int max = 9999;
    var randomizer = new Random();
    var rNum = min + randomizer.nextInt(max - min);
    setState(() {
      widget.randomnum = rNum.toString();
    });
    print(widget.randomnum);

    final body = {
      "to":phoneNumber,
      // "message":"1234 sfT1fyxlGmR",
      "message":"Your OTP Code is "+widget.randomnum+" "+widget.signature,
      "sender":"SMSPoh"
    };

    final response = await http.post(
      Uri.parse(URLS.smsPoh),
      headers: {
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode(body),
    );

    print("Response body : ${response.body}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      print("Response body : ${response.body}");



    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
    }

  }

  _saveRegisterUserStatus()async{

    SharedPreferences sp = await SharedPreferences.getInstance();
    //Storing
    sp.setBool("is_register_avl", true);

    bool? result = sp.getBool("is_register_avl");

    print("is_register_avl is "+result.toString());
  }

  void _faildDialog(String title) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("The Native "),
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _animationController!.forward();

    _listenSmsCode();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _animationController!.dispose();
    super.dispose();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F4FD),
      appBar: AppBar(
        title: const Text("SMS OTP AutoFill"),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:  [
                  Text("Verification"),
                  Text("We sent you a sms otp code to "+widget.phoneNumber,
                    style: TextStyle(
                      // fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: PinFieldAutoFill(
                controller: _pincodeController,
                codeLength: 4,
                autoFocus: true,
                decoration: UnderlineDecoration(
                  lineHeight: 2,
                  lineStrokeCap: StrokeCap.square,
                  bgColorBuilder: PinListenColorBuilder(
                      Colors.green.shade200, Colors.grey.shade200),
                  colorBuilder: const FixedColorBuilder(Colors.transparent),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Resend code after: "),
                Countdown(
                  animation: StepTween(
                    begin: levelClock, // THIS IS A USER ENTERED NUMBER
                    end: 0,
                  ).animate(_animationController!),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 56,
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  //?  use this code to get sms signature for your app
                  // final String signature = await SmsAutoFill().getAppSignature;
                  // print("Signature: $signature");

                  _animationController!.reset();
                  _animationController!.forward();
                  sendOTPSMS(widget.phoneNumber);
                  _listenSmsCode();
                },
                child: const Text("Resend"),
              ),
            ),
            SizedBox(
              height: 56,
              width: 150,
              child: ElevatedButton(
                onPressed:  () {
                  //Confirm and Navigate to Home Page

                  if(widget.randomnum ==  _pincodeController.text){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RegistrationPage(widget.phoneNumber)), (route) => false);
                  }
                  else{
                    _faildDialog("Wrong Pincode");
                  }


                  // Alert(
                  //   context: context,
                  //   type: AlertType.success,
                  //   title: "",
                  //   desc: "Success",
                  //   buttons: [
                  //     DialogButton(
                  //       child: Text(
                  //         "ပိတ်ရန်",
                  //         style: TextStyle(color: Colors.white, fontSize: 20),
                  //       ),
                  //       onPressed: () {
                  //         _saveRegisterUserStatus();
                  //         Navigator.pop(context);
                  //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RegistrationPage("09698012415")), (route) => false);
                  //       },
                  //       width: 120,
                  //     )
                  //   ],
                  // ).show();
                } ,
                child: const Text("Confirm"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Text(
      timerText,
      style: TextStyle(
        fontSize: 18,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}