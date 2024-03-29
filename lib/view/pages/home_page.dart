
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:the_native_flutter/provider/user_provider.dart';
import 'package:the_native_flutter/view/pages/about_page.dart';
// import 'package:farm_flutter/view/profile/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_native_flutter/view/pages/profile_page.dart';
import 'package:the_native_flutter/view/pages/crop_monitoring/soil_population_page.dart';
import 'package:the_native_flutter/view/pages/splash_screen_page.dart';

import '../../provider/crop_monitioring_provider.dart';
import '../../provider/login_provider.dart';
import '../../provider/refresh_token_provider.dart';
import '../../utils/dialogue.dart';
import '../../utils/global.dart';
import '../widgets/weather_widget.dart';
import 'crop_monitoring/crop_monitoring_system_page.dart';
import 'crop_monitoring/draw_polygon_page.dart';
import 'crop_monitoring/draw_polygon_using_point_page.dart';
import 'crop_monitoring/eos_anylysis_image_history_page.dart';
import 'member_page.dart';
import 'news_page.dart';

class HomePage extends StatefulWidget {
  String phoneNo;
  HomePage({required this.phoneNo});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var _currentIndex = 0;

  final ScrollController scrollcontroller = new ScrollController();

  bool scroll_visibility = true;

  _saveRegisterUserStatus()async{

    SharedPreferences sp = await SharedPreferences.getInstance();
    //Storing
    sp.setBool("is_register_avl", true);
    sp.setString("regPhoneNo",widget.phoneNo);

    bool? result = sp.getBool("is_register_avl");

    print("is_register_avl HomePage is "+result.toString()+widget.phoneNo);
    String checkResult = await Provider.of<UserProvider>(context,listen: false).checkUser(widget.phoneNo,prefs.get("accessToken").toString());

    print("checkResult is "+checkResult.toString());

    if(checkResult == "401"){
      refreshToken();
    }

  }

  refreshToken()async{
    String checkResultRefreshToken = await Provider.of<RefreshTokenProvider>(context,listen: false).RefreshToken(prefs.get("accessToken").toString(), prefs.get("refreshToken").toString());

    print("checkResultRefreshToken is "+checkResultRefreshToken.toString());

    if(checkResultRefreshToken == "ok"){
      prefs.setString("Testing", "Hello Babylay 1");
      print(prefs.get("Testing"));

      // print(Provider.of<RefreshTokenProvider>(context,listen: false).refreshTokenModelData.accessToken);

      prefs.setString("accessToken",Provider.of<RefreshTokenProvider>(context,listen: false).refreshTokenModelData.accessToken);
      prefs.setString("refreshToken",Provider.of<RefreshTokenProvider>(context,listen: false).refreshTokenModelData.refreshToken);

      // prefs.setString("Testing", "Hello Babylay 2");
      print(prefs.get("Testing"));

      // print(prefs.get("accessToken").toString());

      Provider.of<UserProvider>(context,listen: false).checkUser(widget.phoneNo,prefs.get("accessToken").toString());
    }
    else{
      _clearSPforLogout();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
              (Route<dynamic> route) => false
      );
    }

  }

  //SharedPreferences ထဲမှာသိမ်းထားတာတွေကို အကုန် clear လုပ်တာပါ
  _clearSPforLogout()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    //Storing
    sp.setBool("is_register_avl", false);
    sp.setString("regPhoneNo","");
    Provider.of<UserProvider>(context,listen: false).logout();
  }

  //Log out or not confirm dialog box
  void QuitConfirmDialogBox() {
    Navigator.of(context).pop();//to close loading dialog
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("The Native "),
          content: Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: new Text("Will you quit?"),
          ),
          actions: <Widget>[
            // CupertinoDialogAction(
            //   isDefaultAction: true,
            //   child: Text("This phone number is already registered",style: TextStyle(color: Colors.red,fontSize: 12.0)),
            // ),
            new TextButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.pop(context);

              },
            ),
            new TextButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.pop(context);
                _clearSPforLogout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
                        (Route<dynamic> route) => false
                );

              },
            )
          ],
        );
      },
    );
  }

  //Delete account or not confirm dialog box
  void DeleteAccountConfirmDialogBox() {
    Navigator.of(context).pop();//to close loading dialog
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("The Native "),
          content: Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: new Text("Will you delete your account?"),
          ),
          actions: <Widget>[
            // CupertinoDialogAction(
            //   isDefaultAction: true,
            //   child: Text("This phone number is already registered",style: TextStyle(color: Colors.red,fontSize: 12.0)),
            // ),
            new TextButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.pop(context);

              },
            ),
            new TextButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.pop(context);
                _clearSPforLogout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
                        (Route<dynamic> route) => false
                );

              },
            )
          ],
        );
      },
    );
  }

  getEosImageHistory()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String regPhoneNo = sp.getString("regPhoneNo")?? "";
    String result = await Provider.of<UserProvider>(context,listen: false).checkUser(regPhoneNo,Provider.of<LoginProvider>(context,listen: false).loginModelData.token);
    String userId  = Provider.of<UserProvider>(context,listen: false).userModel.UserID;
    bool status = await Provider.of<CropMonitoringProvider>(context,listen: false).getEosAnalysedImageHistory(userId);
    bool crop_monitoring_index_status = await Provider.of<CropMonitoringProvider>(context,listen: false).getCropMonitoringIndex();
  }

  @override
  void initState() {
    // TODO: implement initState

    scrollcontroller.addListener(() {
      if(scrollcontroller.position.pixels > 0 || scrollcontroller.position.pixels < scrollcontroller.position.maxScrollExtent)
        scroll_visibility = false;
      else
        scroll_visibility = true;

      setState(() {});
    });

    _saveRegisterUserStatus();

    getEosImageHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<UserProvider>(context,listen: false).checkUser(widget.phoneNo,Provider.of<LoginProvider>(context,listen: false).loginModelData.token);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    radius: 70.0,
                    backgroundImage: AssetImage('assets/images/logo.jpg'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Text("ဇာတိမြေ",style: TextStyle(color: Colors.white),),
            ],
          ),
          backgroundColor: Colors.lightGreen,
        ),
        drawer: Drawer(
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.lightGreen,
                        ), //BoxDecoration
                        child: UserAccountsDrawerHeader(
                          decoration: BoxDecoration(color: Colors.lightGreen),
                          accountName: Text(
                            Provider.of<UserProvider>(context,listen: true).userModel.UserName,
                            style: TextStyle(fontSize: 18),
                          ),
                          accountEmail: Text(""),
                          currentAccountPictureSize: Size.square(40),
                          // currentAccountPicture: CircleAvatar(
                          //   backgroundColor: Color.fromARGB(255, 165, 255, 137),
                          //   child: Text(
                          //     "A",
                          //     style: TextStyle(fontSize: 30.0, color: Colors.blue),
                          //   ), //Text
                          // ), //circleAvatar
                          currentAccountPicture: ClipRRect(
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
                          ), //circleAvatar

                        ), //UserAccountDrawerHeader
                      ), //DrawerHeader
                     /*
                      ListTile(
                        leading: const Icon(Icons.map),
                        title: const Text('စိုက်ခင်းအခြေအနေကြည့်ရှုရန်',style: TextStyle(fontWeight: FontWeight.bold),),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CropMonitoringSystemPage()));
                        },
                      ),

                      */
                      ListTile(
                        leading: const Icon(Icons.map,color: Colors.blue,),
                        title: const Text('စိုက်ခင်းဧရိယာသတ်မှတ်ရန်',style: TextStyle(fontWeight: FontWeight.bold),),
                        onTap: ()async {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> DrewPolygonPage()));


                          /*
                          Dialogs.showLoadingDialog(context, _keyLoader);
                          SharedPreferences sp = await SharedPreferences.getInstance();
                          String regPhoneNo = sp.getString("regPhoneNo")?? "";

                          String result = await Provider.of<UserProvider>(context,listen: false).checkUser(regPhoneNo,Provider.of<LoginProvider>(context,listen: false).loginModelData.token);

                          Navigator.of(context).pop();
                          if(result == "0k"){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> DrawPolygonUsingPointPage()));
                          }

                           */
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> DrawPolygonUsingPointPage()));

                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.data_exploration,color: Colors.blue,),
                        title: const Text('စိုက်ခင်းဧရိယာပြန်လည်ကြည့်ရှုရန်',style: TextStyle(fontWeight: FontWeight.bold),),
                        onTap: () async{

                          Dialogs.showLoadingDialog(context, _keyLoader);

                          SharedPreferences sp = await SharedPreferences.getInstance();
                          String regPhoneNo = sp.getString("regPhoneNo")?? "";
                          //String result = await Provider.of<UserProvider>(context,listen: false).checkUser(regPhoneNo,Provider.of<LoginProvider>(context,listen: false).loginModelData.token);
                          Navigator.of(context).pop();

                          /*

                          if(result == "0k"){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> EosAnalysisImageHistoryPage()));
                          }

                           */

                          Navigator.push(context, MaterialPageRoute(builder: (context)=> EosAnalysisImageHistoryPage()));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete,color: Colors.red,),
                        title: const Text('Delete Account'),
                        onTap: () {
                          DeleteAccountConfirmDialogBox();

                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout,color: Colors.blue,),
                        title: const Text('LogOut'),
                        onTap: () {
                          QuitConfirmDialogBox();

                        },
                      ),

                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(versionName,style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            )
          ),
        ),
        body:_currentIndex == 0 ? NewsPage():_currentIndex == 1 ? MemberPage() :_currentIndex == 2 ?ProfilePage():AboutPage(),

      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.green,          ),

          /// Member
          SalomonBottomBarItem(
            icon: Icon(Icons.group),
            title: Text("Member"),
            selectedColor: Colors.green,
          ),


          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.green,          ),

          /// About
          SalomonBottomBarItem(
            icon: Icon(Icons.assignment),
            title: Text("About"),
            selectedColor: Colors.green,
          ),
        ],
      ),
    );
  }

}
