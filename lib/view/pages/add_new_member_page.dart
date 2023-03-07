import 'package:the_native_flutter/provider/user_provider.dart';
import 'package:the_native_flutter/utils/dialogue.dart';
import 'package:the_native_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewMemberPage extends StatefulWidget {
  const AddNewMemberPage({Key? key}) : super(key: key);

  @override
  State<AddNewMemberPage> createState() => _AddNewMemberPageState();
}

class _AddNewMemberPageState extends State<AddNewMemberPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController mCodeController = TextEditingController();

  sendMemberCodeF(String mCode)async{
    String UserID = await Provider.of<UserProvider>(context,listen: false).userModel.UserID.toString();
    if(UserID == "UserID")
      Navigator.of(context);

    await ApiService.sendMemberCode(mCode,UserID).then((value) {
      Navigator.pop(context);
      if(value == '0'){
        statusDialog("တစ်ခုခုမှားယွင်းနေသည်");
      }
      else if(value == '3'){
        statusDialog("Member Request တောင်းထားသည်");
      }else if(value == '2'){
        statusDialog("Member Code မှားနေသည်");
      }else if(value == '1'){
        statusDialog("အဖွဲ့ဝင် ဖြစ်ပြီးဖြစ်သည်");
      }else {
        statusDialog("error message");
      }
    });
  }

  void statusDialog(String title) {
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
            new TextButton(
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

  OutlineInputBorder myinputborder(){ //return type is OutlineInputBorder
    return OutlineInputBorder( //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color:Colors.green,
          width: 3,
        )
    );
  }

  OutlineInputBorder myfocusborder(){
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color:Colors.greenAccent,
          width: 3,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0.0,
        centerTitle: true,
        title: new Text('Member Area',
            style: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.white)),
      ),
      body: new SingleChildScrollView(
        padding: new EdgeInsets.only(bottom: 20.0),
        child: new Center(
          child: new Form(
            //key: _formKey,
            child: new Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Card(
                    margin: new EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 8.0, bottom: 5.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 4.0,
                    child: new Padding(
                      padding: new EdgeInsets.all(25.0),
                      child: new Column(
                        children: <Widget>[
                          // new Container(
                          //   child: new TextFormField(
                          //     maxLines: 1,
                          //     controller: mCodeController,
                          //     // textInputAction: TextInputAction.next,
                          //     keyboardType: TextInputType.text,
                          //     decoration:
                          //     new InputDecoration(labelText: 'Enter Code'),
                          //     onFieldSubmitted: (value) {
                          //       //FocusScope.of(context).requestFocus(_phoneFocusNode);
                          //     },
                          //     // validator: (value) {
                          //     //   if (value.isEmpty) {
                          //     //     return 'Type your name';
                          //     //   }
                          //     // },
                          //   ),
                          // ),
                          TextField(
                              controller: mCodeController,
                              decoration: InputDecoration(
                                labelText: "Member Code",
                                hintText: 'Enter Member Code',
                                prefixIcon: Icon(Icons.people),
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                                focusedBorder: myfocusborder(),
                              )
                          ),
                          new Padding(padding: new EdgeInsets.only(top: 30.0)),
                          new TextButton(
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.green)
                                    )
                                )
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  'Submit',
                                  style: new TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () {
                              //_persistFormData();
                              Dialogs.showLoadingDialog(context, _keyLoader);

                              sendMemberCodeF(mCodeController.text);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
