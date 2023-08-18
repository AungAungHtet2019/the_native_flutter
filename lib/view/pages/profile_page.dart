
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cipher2/cipher2.dart';
import 'package:the_native_flutter/provider/user_provider.dart';
import 'package:the_native_flutter/utils/dialogue.dart';
import 'package:the_native_flutter/utils/global.dart';
import 'package:the_native_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_native_flutter/view/pages/reported_case/case_reply_page.dart';
import 'package:the_native_flutter/view/pages/reported_case/report_detail_page.dart';

import '../../provider/login_provider.dart';
import '../../provider/report_history_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int counter = 0;
  bool register_status = false;
  String regPhoneNo = "";

  late XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool updateSuccess = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  List<String> _list = [];
  // var singleline;
  List<bool> selected = [];

  String encryptedUID = "";

  Future getImage() async {
    // var image = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 25);
    // var image = await ImagePicker.platform.getImage(source: ImageSource.camera,imageQuality: 25);
    // Capture a photo
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);


    setState(() {
      _image = photo;
      _handleSubmit(context);
    });
  }

  Future getGalleryImage() async {
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 25);
    // var image = await ImagePicker.platform.getImage(source: ImageSource.gallery,imageQuality: 25);
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      _handleSubmit(context);

    });
  }

  _submit(File proFile_pic) async {
    // Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    String base64proFile_pic = base64Encode(proFile_pic.readAsBytesSync());
    Map body={
      "userID":Provider.of<UserProvider>(context,listen: false).userModel.UserID,
      'fileName':_image?.name.toString(),
      'base64': base64proFile_pic,
    };
    var jsonbody = json.encode(body);
    await ApiService.uploadUserProfilePicture(jsonbody).then((success) {
      print("++++++++++++++++++++++++"+success.toString());
      print("***********************");
      if(success.toString() =="Ok"){
        Navigator.of(context).pop();//close the dialoge
        _sendDataSucccessDialog();
        Provider.of<UserProvider>(context,listen: false).checkUser(prefs.get("regPhoneNo").toString(),prefs.get("accessToken").toString());
        Provider.of<UserProvider>(context,listen: false).userModel.ProfilePicture;
      }
      else{
        Navigator.of(context).pop();//close the dialoge
        _sendDataFildDialog();
      }
    });
  }


  /*
  uploadProfilePicture(File proFile_pic)async{
    String base64proFile_pic = base64Encode(proFile_pic.readAsBytesSync());

    String uId =   await  Provider.of<UserProvider>(context,listen: false).userModel.UserID;
    String plainData = uId+","+base64proFile_pic;
    print("plainData for uploadProfilePicture "+plainData);

    String aesEncryptedData = await Cipher2.encryptAesCbc128Padding7(plainData, key, iv);
    print("uploadProfilePicture aesEncryptedData is "+aesEncryptedData);

    Map body={
      "Data":"$aesEncryptedData"
    };

    var jsonbody = json.encode(body);
    await ApiService.updateProfilePicture(jsonbody).then((value){
      print("uploadProfilePicture Value is "+value);
      if(value == "1"){
        print(" uploadProfilePicture success");
        setState(() {
          updateSuccess = true;
          Provider.of<UserProvider>(context,listen: false).checkUser(regPhoneNo,Provider.of<LoginProvider>(context,listen: false).loginModelData.token);
          Provider.of<UserProvider>(context,listen: false).userModel.ProfilePicture;
          Navigator.of(context).pop();//close the dialoge
          _sendDataSucccessDialog();
        });
      }
      else{
        print(" uploadProfilePicture unsuccess");
        setState(() {
          updateSuccess = false;
          Navigator.of(context).pop();//close the dialoge
          _sendDataFildDialog();
        });
      }
    });
  }

  */
  void _needTofillAllDataDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("MWD Pay"),
          content: Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: new Text("Please,Upload image"),
          ),
          actions: <Widget>[

            CupertinoDialogAction(
              child:   new TextButton (
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();//close the dialoge
                },
              ),
            )
          ],
        );
      },
    );
  }
  Future<void>_showChoiceDialog(BuildContext context,){
    return showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Choose option"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  getImage();
                  Navigator.of(context).pop();
                  // Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                  //  _getTransferPersonData(_controllerChoosePhoneNo.text,"AG100");
                  //  _openGallery(context);
                },
                title: Text("Camera"),
                leading: Icon(Icons.camera_alt,color: Colors.blue,),
              ),

              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){

                  getGalleryImage();
                  Navigator.of(context).pop();

                  //  Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                  //  _getTransferPersonData(_controllerChoosePhoneNo.text,"Client100");
                  //  _openCamera(context);
                },
                title: Text("Gallery"),
                leading: Icon(Icons.image,color: Colors.blue,),
              ),
            ],
          ),
        ),);
    });
  }

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

      print("_image is "+_image.toString());
      if(_image == "null" ){
        _needTofillAllDataDialog();
      }
      else{
        // uploadProfilePicture(File(_image!.path));
        _submit(File(_image!.path));
      }
    } catch (error) {
      print("this is your error "+error.toString());
    }
  }

  void _sendDataSucccessDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("Success"),
          content: Padding(
            padding: const EdgeInsets.only(top:17.0),
            child: new Text("Upload Successfully"),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child:   new TextButton (
                child: new Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>TestHomePage(globaTtoken,thisUserPhoneNumber)), (Route<dynamic> route) => false);
                },
              ),
            )
          ],
        );
      },
    );
  }

  void _sendDataFildDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("Something Wrong"),
          //content: new Text("Your Balance is insufficient"),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Data cannot send"),
            ),
            CupertinoDialogAction(
              child:   new TextButton (
                child: new Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        );
      },
    );
  }


  _saveRegisterUserStatus()async{

    print("pro page");
    SharedPreferences sp = await SharedPreferences.getInstance();
    // //Storing
    // sp.setBool("is_register_avl", true);

    register_status = sp.getBool("is_register_avl")?? false;
    setState(() {
      regPhoneNo = sp.getString("regPhoneNo")?? "";
    });

    print("is_register_avl ProfilePage  is "+register_status.toString()+regPhoneNo);
    Provider.of<UserProvider>(context,listen: false).checkUser(regPhoneNo,Provider.of<LoginProvider>(context,listen: false).loginModelData.token);
    // Provider.of<UserProvider>(context,listen: false).userModel.ProfilePicture;
    print("hello is "+Provider.of<UserProvider>(context,listen: false).userModel.ProfilePicture.toString());
  }

  Future<String> insertLikedCategory(String cID)async{

    String uId =   await  Provider.of<UserProvider>(context,listen: false).userModel.UserID;
    String plainData = uId+","+cID;
    print("plainData for insertLikedCategory "+plainData);

    /*
    String aesEncryptedData = await Cipher2.encryptAesCbc128Padding7(plainData, key, iv);
    print("insertLikedCategory aesEncryptedData is "+aesEncryptedData);

    Map body={
      "Data":"$aesEncryptedData"
    };
    */

    Map body={
      "userID":"$uId",
      "categoryID":"$cID"
    };

    var jsonbody = json.encode(body);
    return jsonbody;

  }

  encryptUID()async{

    String uId =   await  Provider.of<UserProvider>(context,listen: false).userModel.UserID;
    String plainData = uId;
    print("plainData for encryptUID "+plainData);

    /*
    String aesEncryptedData = await Cipher2.encryptAesCbc128Padding7(plainData, key, iv);
    print("encryptUID aesEncryptedData is "+aesEncryptedData);

    Map body={
      "Data":"$aesEncryptedData"
    };
    */

    Map body={
      "userID":"$uId"
    };

    var jsonbody = json.encode(body);
    setState(() {
      encryptedUID = jsonbody;
    });
    await Provider.of<UserProvider>(context,listen: false).getLikedCategory(encryptedUID);
  }

  getData()async{
    SharedPreferences sp = await SharedPreferences.getInstance();

    await Provider.of<UserProvider>(context,listen: false).getCategory();
    setState(() {
      for (int i = 0; i < Provider.of<UserProvider>(context,listen: false).categoryList.length; i++) {
        _list.insert(0, '${Provider.of<UserProvider>(context,listen: false).categoryList[i]}');
        if(Provider.of<UserProvider>(context,listen: false).likedCategoryList.contains(Provider.of<UserProvider>(context,listen: false).categoryList[i])){
          selected.insert(0, true);
        }else{
          selected.insert(0, false);
        }

      }
    });
    Provider.of<UserProvider>(context,listen: false).checkUser(regPhoneNo,Provider.of<LoginProvider>(context,listen: false).loginModelData.token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _saveRegisterUserStatus();
    encryptUID();
    getData();


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 110.0,),
          InkWell(
            child:
                Provider.of<UserProvider>(context,listen: true).userModel.ProfilePicture == "ProfilePicture" ?
            Center(
              child: CircleAvatar(
                radius: 70.0,
                backgroundImage: AssetImage('assets/images/profile-unknown.png'),
                backgroundColor: Colors.white,
              ),
            )
                : Center(
                //   child: CircleAvatar(
                //     radius: 70.0,
                //     backgroundImage:MemoryImage( Base64Decoder().convert(Provider.of<UserProvider>(context,listen: true).userModel.UserProfilePicture)),
                //     backgroundColor: Colors.white,
                //
                //     // child: ClipOval(
                //     //   child: CachedMemoryImage(
                //     //     width: 180,
                //     //     height: 180,
                //     //     fit:BoxFit.cover,
                //     //     uniqueKey: 'app://image/1',
                //     //     errorWidget: const Text('Error'),
                //     //     base64: Provider.of<UserProvider>(context,listen: true).userModel.ProfilePicture,
                //     //     placeholder: const CircularProgressIndicator(),
                //     //   ),
                //     // ),
                // ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(800),
                    child: CachedNetworkImage(
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                            imageUrl: Provider.of<UserProvider>(context,listen: true).userModel.DomainName+Provider.of<UserProvider>(context,listen: true).userModel.UserProfilePicture,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                  ),

            ),

            onTap: (){
              _showChoiceDialog(context);
            },
          ),
          SizedBox(height: 10.0,),
          Center(
            child: Text(
              // 'ဦးမြင့်ကြိုင်',
                Provider.of<UserProvider>(context,listen: true).userModel.UserName,
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 20.0,
                )),
          ),
          SizedBox(height: 5.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              // elevation: 7,
                child: Padding(
                  padding:EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [


                      Container(
                        child: Column(
                            children: [
                              Text(
                                'Birthday',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14.0
                                ),),
                              SizedBox(height: 5.0,),
                              Text(
                                // 'April 7th',

                                Provider.of<UserProvider>(context,listen: true).userModel.DateOfBirth.toString() == "DateOfBirth" ? "": Provider.of<UserProvider>(context,listen: true).userModel.DateOfBirth.split('T')[0] ,

                                style: TextStyle(
                                  fontSize: 15.0,
                                ),)
                            ]),
                      ),

                      Container(
                          child:Column(
                            children: [
                              Text('Age',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14.0
                                ),),
                              SizedBox(height: 5.0,),
                              Text(
                                // '39 yrs',
                                Provider.of<UserProvider>(context,listen: true).userModel.DateOfBirth.toString() == "DateOfBirth" ? "" : DateTime.now().year - int.parse(Provider.of<UserProvider>(context,listen: true).userModel.DateOfBirth.split('-')[0]) == 0 ? "1 year" :"${ DateTime.now().year - int.parse(Provider.of<UserProvider>(context,listen: true).userModel.DateOfBirth.split('-')[0]) } yrs",
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),)
                            ],
                          )
                      ),
                    ],
                  ),
                )
            ),
          ),
          _list.isNotEmpty ?Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                    title: ExpansionTile(
                      title: Center(child: Text("Categories")),
                      children: Provider.of<UserProvider>(context,listen: true).categoryList.map((e) {
                        var index = Provider.of<UserProvider>(context,listen: true).categoryList.indexOf(e);
                        return CheckboxListTile(
                      title: Text(e.CategoryName),
                      // value: selected[index],
                      value:  Provider.of<UserProvider>(context,listen: true).likedCategoryList.contains(e.CategoryCode) ? true : selected[index],
                      onChanged: (val) async{
                        Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
                        String result = await insertLikedCategory(e.CategoryCode);

                        selected[index] = val!;
                        print("index is "+index.toString()+val.toString());
                        val == false ? Provider.of<UserProvider>(context,listen: false).deleteLikedCategory(result):
                        Provider.of<UserProvider>(context,listen: false).insertLikedCategory(result);
                        Provider.of<UserProvider>(context,listen: false).getLikedCategory(encryptedUID);
                        getData();
                        Navigator.pop(context);

                      },
                    );
                }).toList(),
              ),
                  ),
            ),
          ):Container(),

          /*
          ListView.builder(
              itemCount: Provider.of<ReportHistoryProvider>(context,listen: true).ReportHistoryModel.length,
              itemBuilder: (context,index){
                return Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          child: Provider.of<ReportHistoryProvider>(context,listen: false).ReportHistoryModel[index].UserProfilePicture == "User_Profile_Picture" ? CircleAvatar(
                                            radius: 70.0,
                                            backgroundImage: AssetImage('assets/images/profile-unknown.png'),
                                            backgroundColor: Colors.white,
                                          ):ClipRRect(
                                            borderRadius: BorderRadius.circular(800),
                                            child: CachedNetworkImage(
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                              imageUrl: Provider.of<ReportHistoryProvider>(context,listen: false).ReportHistoryModel[index].DomainName+Provider.of<ReportHistoryProvider>(context,listen: false).ReportHistoryModel[index].UserProfilePicture,
                                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                  CircularProgressIndicator(value: downloadProgress.progress),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:Container(
                                                child:Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:[
                                                      Text(Provider.of<ReportHistoryProvider>(context,listen: true).ReportHistoryModel[index].PersonName,style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Row(
                                                        children: [
                                                          Text((Provider.of<ReportHistoryProvider>(context,listen: true).ReportHistoryModel[index].CreatedDate.replaceAll("T", " ")).split(".")[0]),
                                                          Container(
                                                            height: 15,
                                                            width: 20,
                                                            // child: CircleAvatar(
                                                            //   backgroundImage: AssetImage('assets/icons/world.png'),
                                                            //   backgroundColor: Colors.white,
                                                            // ),
                                                            child: Image.asset('assets/icons/world.png'),
                                                          ),
                                                        ],
                                                      )
                                                    ]
                                                )
                                            )

                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Text(Provider.of<ReportHistoryProvider>(context,listen: true).ReportHistoryModel[index].CaseSubject,style: TextStyle(fontWeight: FontWeight.bold),),
                      ReportDetailPage(Provider.of<ReportHistoryProvider>(context,listen: true).ReportHistoryModel[index]
                        // ,reportHistoryModel[index].CaseID
                      ),
                      Divider(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    height: 25,
                                    width:25,
                                    child: Image.asset("assets/icons/paper-plane.png")),
                                Text("ပြန်ကြားစာ"
                                  ,style: TextStyle(fontWeight: FontWeight.bold),),

                                //ပြန်ကြားစာအရေအတွက်အား (အထက်ဌာနမှ ပြန်ကြားသည့်အရေအတွက်သာဖော်ပြန်ရန်) ကိုယ်မဟုတ်သည့်ပြန်ကြားစာအရေအတွက်ဖော်ပြထားခြင်းဖြစ်သည်။
                               // Text(" "+Provider.of<ReportHistoryProvider>(context,listen: true).ReportHistoryModel[index].caseReplied.where((e) => e.PersonID != widget.userID).toList().length.toString()+" စောင်",style: TextStyle(fontWeight: FontWeight.bold),)

                              ],
                            ),
                          ),
                          onTap: (){
                            /*
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CaseReplyListPage(
                                widget.userID,
                                widget.groupID,
                                Provider.of<ReportHistoryProvider>(context,listen: false).ReportHistoryModel[index].CaseID,
                                Provider.of<ReportHistoryProvider>(context,listen: false).ReportHistoryModel[index].CaseSubject,
                                index)));
                            // showDialogBox(Provider.of<ReportHistoryProvider>(context,listen: false).reportHistoryModel[index].CaseID,Provider.of<ReportHistoryProvider>(context,listen: false).reportHistoryModel[index].caseReplied);

                             */
                          },
                        ),
                      ),
                      Divider(
                        height: 10,
                      )
                    ],
                  ),
                );

              })

           */
        ],
      ),
    );
  }
}

