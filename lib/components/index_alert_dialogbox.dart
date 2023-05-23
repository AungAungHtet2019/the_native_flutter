import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndexDialogBox extends StatefulWidget {
  final String title,text;

  const IndexDialogBox({Key? key, required this.title,  required this.text}) : super(key: key);

  @override
  _IndexDialogBoxState createState() => _IndexDialogBoxState();
}

class _IndexDialogBoxState extends State<IndexDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),)),
              SizedBox(height: 15,),
              Row(
                children: [
                  Container(
                    color: Colors.red,
                    width: 10,
                    height: 10,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("၀.၀၃၅ - ၀.၁၉၇",style: TextStyle(fontSize: 16),textAlign: TextAlign.start,),
                      Text("ပျိုးပင်မရှိသည့်မြေ",style: TextStyle(fontSize: 18),textAlign: TextAlign.start,),
                    ],
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    color: Colors.orange,
                    width: 10,
                    height: 10,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("၀.၁၉၇ - ၀.၃၅၉",style: TextStyle(fontSize: 16),textAlign: TextAlign.start,),
                      Text("ဖွံ့ဖြိုးမှုကျဆင်းသောပျိုးပင်များ",style: TextStyle(fontSize: 18),textAlign: TextAlign.start,),
                    ],
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    color: Colors.yellow,
                    width: 10,
                    height: 10,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("၀.၃၅၉ - ၀.၅၂၁",style: TextStyle(fontSize: 16),textAlign: TextAlign.start,),
                      Text("ဖွံ့ဖြိုးမှုအသင့်အတင့်ရှိသောပျိုးပင်များ",style: TextStyle(fontSize: 18),textAlign: TextAlign.start,),
                    ],
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    color: Colors.lightGreen,
                    width: 10,
                    height: 10,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("၀.၅၂၁ - ၀.၆၈၃",style: TextStyle(fontSize: 16),textAlign: TextAlign.start,),
                      Text("ဖွံ့ဖြိုးမှုကောင်းသောပျိုးပင်များ",style: TextStyle(fontSize: 18),textAlign: TextAlign.start,),
                    ],
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    color: Colors.green,
                    width: 10,
                    height: 10,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("၀.၆၈၃ - ၀.၈၄၄ ",style: TextStyle(fontSize: 16),textAlign: TextAlign.start,),
                      Text("ဖွံ့ဖြိုးမှုအကောင်းဆုံးပျိုးပင်များ",style: TextStyle(fontSize: 18),textAlign: TextAlign.start,),

                    ],
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(widget.text,style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/images/logo.jpg")
            ),
          ),
        ),
      ],
    );
  }
}

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}