import 'dart:convert';

// import 'package:cipher2/cipher2.dart';
import 'package:provider/provider.dart';
import 'package:the_native_flutter/utils/dialogue.dart';
import 'package:the_native_flutter/utils/global.dart';
import 'package:the_native_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import '../../constants.dart';
import '../../provider/login_provider.dart';
import 'home_page.dart';

class RegistrationPage extends StatefulWidget {
  // const RegistrationPage({Key? key}) : super(key: key);

  String phoneNumber;
  RegistrationPage(this.phoneNumber);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();


  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime dateTime = DateTime.now();
  bool showDate = false;
  bool showTime = false;
  bool showDateTime = false;

  // Select for Date
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }


  // Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }
  // select date time picker

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    if (date == null) return;

    final time = await _selectTime(context);

    if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  String getDate() {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('MMM d, yyyy').format(selectedDate);
    }
  }

  String getDateTime() {
    // ignore: unnecessary_null_comparison
    if (dateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('yyyy-MM-dd HH: ss a').format(dateTime);
    }
  }

  String getTime(TimeOfDay tod) {
    final now = DateTime.now();

    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }


  getToken()async{

    String myresult =  await Provider.of<LoginProvider>(context,listen: false).LoginUser(widget.phoneNumber);

    prefs.setString("accessToken",Provider.of<LoginProvider>(context,listen: false).loginModelData.token);
    prefs.setString("refreshToken",Provider.of<LoginProvider>(context,listen: false).loginModelData.refreshToken);

    if(prefs.get("accessToken").toString() != ''){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage(phoneNo: widget.phoneNumber,)), (route) => false);
    }

  }

  _registration(String name,String phoneNo,String dob)async{


    String finalPlainText = name+","+phoneNo+","+dob;

    /*
    String aesEncryptedData = await Cipher2.encryptAesCbc128Padding7(finalPlainText, key, iv);
    print(" _myEncryptData _registration is "+aesEncryptedData);
    Map body={
      "Data":"$aesEncryptedData"
    };

     */

    Map body={
      "userName":"$name",
      "phoneNO":"$phoneNo",
      "DOB":"$dob"
    };
    var jsonbody = json.encode(body);
    await ApiService.InsertUser(jsonbody).then((success) {
      print("++++++++++++++++++++++++"+success.toString());
      // final _response=success.replaceAll("[", "").replaceAll("]", "");
      // Map<String, dynamic> jsonData = json.decode(_response) as Map<String, dynamic>;
      // print("***********************");
      // print("-------"+jsonData["Respone"].toString());
      if(success.toString()=="Ok")
      {
        Navigator.pop(context);
        // _alreadyRegistered("This NRC Number is already registered.");
        getToken();
      }
      else{
        _faildDialog("Sorry");
      }

    });
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
                Navigator.pop(context);

              },
            )
          ],
        );
      },
    );
  }

  //18 နှစ်ပြည့်မပြည့်စစ်သည်ပြီး အကြောင်းပြန်သည့် function ဖြစ်သည်
  bool isAdult(String birthDateString) {
    String datePattern = "yyyy-MM-dd";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff > 18 || yearDiff == 18 && monthDiff >= 0 && dayDiff >= 0;
  }

  void _RequireAlertDialog(String error_title) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("The Native",style: myTextStyleRedalertDialogBoxTitleFontSize),
          content: Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: new Text(error_title,style: myTextStyleRedalertDialogBoxFontSize),
          ),
          actions: <Widget>[
            new TextButton (
              child: new Text("Ok",style: myTextStyleRedBoldalertDialogBoxFontSize,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }



  @override
  void initState() {



    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Padding(
            //   padding: EdgeInsets.only(top: size.height * 0.02),
            //   child: Align(
            //     child: Text(
            //       'Hey there,',
            //       style: GoogleFonts.poppins(
            //         color: isDarkMode
            //             ? Colors.white
            //             : const Color(0xff1D1617),
            //         fontSize: size.height * 0.02,
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.015),
              child: Align(
                child: Text(
                  'Registration',
                  style: GoogleFonts.poppins(
                    color: isDarkMode
                        ? Colors.white
                        : const Color(0xff1D1617),
                    fontSize: size.height * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                )

              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.01),
            ),
            Padding(
              // padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              padding: EdgeInsets.only(left: 30,right: 30),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                // obscureText: true,
                keyboardType: TextInputType.text,
                cursorColor: kPrimaryColor,
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.person),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 20,right: 20),

              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,

                child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: kPrimaryLightColor,
                          shape: const StadiumBorder(),
                          maximumSize: const Size(double.infinity, 56),
                          minimumSize: const Size(double.infinity, 56),
                        ),
                  onPressed: () {
                    _selectDate(context);
                    showDate = true;
                  },
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today,color: kPrimaryColor,),
                      SizedBox(width: 10,),
                      Text(showDate ? getDate() :"Date of Birth",style: TextStyle(color: Colors.black45),),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 20,right: 20),

              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () {
                    print("hello"+isAdult(selectedDate.toString()).toString());
                    if (isAdult(selectedDate.toString())==true){

                      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
                      // getToken();
                      _registration(_nameController.text,widget.phoneNumber,getDate());

                    }else{
                      _RequireAlertDialog("Your age must be greater than 10 years old. ");
                    }

                  },
                  child: Text("Submit")
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
