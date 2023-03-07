import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_native_flutter/view/pages/phone_number_page.dart';

import '../../utils/global.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool register_status = false;
  String regPhoneNo = "";
  _saveRegisterUserStatus()async{

    prefs = await SharedPreferences.getInstance();
    prefs.setString("Testing", "Hello Babylay");
    print(prefs.get("Testing"));

    SharedPreferences sp = await SharedPreferences.getInstance();
    // //Storing
    // sp.setBool("is_register_avl", true);

    register_status = sp.getBool("is_register_avl")?? false;
    regPhoneNo = sp.getString("regPhoneNo")?? "";

    print("is_register_avl is "+register_status.toString()+regPhoneNo);
  }

  @override
  void initState() {

    _saveRegisterUserStatus();

    super.initState();
    Timer(
        Duration(seconds: 3),
            () {
              if(register_status == true){

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(phoneNo:regPhoneNo))
                );
              }
              else{
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PhoneNumberPage()
                    // RegistrationPage("09698012415")
                )
                );
              }
            }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo.jpg'),
      ),
    );
  }
}