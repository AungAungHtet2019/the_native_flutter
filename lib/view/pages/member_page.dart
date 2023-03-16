import 'dart:convert';

import 'package:card_loading/card_loading.dart';
import 'package:the_native_flutter/model/chatUsersModel.dart';
import 'package:the_native_flutter/model/member_model.dart';
import 'package:the_native_flutter/provider/user_provider.dart';
import 'package:the_native_flutter/utils/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:the_native_flutter/view/pages/chatting/chat_page.dart';
import 'package:the_native_flutter/view/pages/reported_case/report_history_page.dart';
import 'package:the_native_flutter/view/pages/report_page.dart';
import 'package:the_native_flutter/view/pages/success_case/successed_report_history_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../provider/report_history_provider.dart';
import '../../utils/global.dart';
import 'add_new_member_page.dart';
// import 'chat_page.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  List<MemberModel> allMemberModelList = [];
  List allMemberList = [];
  bool dataReturnStatus = false;
  late String groupid;
  bool isExpanded = false;

  void _onRefresh() async{
    getMemberList();
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  getMemberList()async{
    if(Provider.of<UserProvider>(context,listen: false).userModel.UserID.toString() == "UserID"){
      await Provider.of<UserProvider>(context,listen: false).checkUser(prefs.get("regPhoneNo").toString(),prefs.get("accessToken").toString());
    }
    try{
      String UserID = await Provider.of<UserProvider>(context,listen: false).userModel.UserID.toString();

      print("getMemberList UserID "+UserID);
      await ApiService.getMemberList(UserID).then((value) {

        List<dynamic> list = json.decode(value);
        print("getMemberList data is "+list.toString());
        setState(() {
          List<MemberModel> _alist = list.map((e) {
            return MemberModel.fromJson(e);
          }).toList();
          allMemberModelList = _alist;
          dataReturnStatus = true;
        });

        allMemberModelList.map((e) {
          groupid = e.GadiumCode;
          return print(e.PersonName);
        }).toList();

      });
    }catch (Exc) {
      print(Exc);
      // rethrow;
      setState(() {
        dataReturnStatus = true;
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMemberList();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;


    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        // footer: CustomFooter(
        //   builder: (BuildContext context,LoadStatus mode){
        //     Widget body ;
        //     if(mode==LoadStatus.idle){
        //       body =  Text("pull up load");
        //     }
        //     else if(mode==LoadStatus.loading){
        //       body =  CupertinoActivityIndicator();
        //     }
        //     else if(mode == LoadStatus.failed){
        //       body = Text("Load Failed!Click retry!");
        //     }
        //     else if(mode == LoadStatus.canLoading){
        //       body = Text("release to load more");
        //     }
        //     else{
        //       body = Text("No more Data");
        //     }
        //     return Container(
        //       height: 55.0,
        //       child: Center(child:body),
        //     );
        //   },
        // ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        // onLoading: _onLoading,
        child:allMemberModelList.length == 0 && dataReturnStatus == false ? ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardLoading(
                  height: 30,
                  width: size.width * .2,
                  padding: const EdgeInsets.only(bottom: 10),
                  borderRadius: 15,
                ),
                CardLoading(
                  height: size.height * .15,
                  padding: const EdgeInsets.only(bottom: 10),
                  borderRadius: 15,
                ),
                CardLoading(
                  height: size.height * .1,
                  padding: const EdgeInsets.only(bottom: 20),
                  borderRadius: 15,
                ),
              ],
            );
          },
        )
            :allMemberModelList.length == 0 && dataReturnStatus == true  ? Center(
          child: Text("Please request to enter group"),
        )
        //     :GroupedListView<dynamic, String>(
        //   elements: allMemberList,
        //   groupBy: (element) => element['Category_Name'],
        //   groupComparator: (value1, value2) => value2.compareTo(value1),
        //   itemComparator: (item1, item2) =>
        //       item1['Category_Name'].compareTo(item2['Category_Name']),
        //   order: GroupedListOrder.DESC,
        //   useStickyGroupSeparators: true,
        //   groupSeparatorBuilder: (String value) => Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text(
        //       value,
        //       textAlign: TextAlign.center,
        //       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        //   itemBuilder: (c, element) {
        //     return Card(
        //       elevation: 8.0,
        //       margin:
        //       const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        //       child: SizedBox(
        //         child: ListTile(
        //           contentPadding: const EdgeInsets.symmetric(
        //               horizontal: 20.0, vertical: 10.0),
        //           leading: const Icon(Icons.account_circle),
        //           title: Text(element['Person_Name']),
        //           // trailing: const Icon(Icons.arrow_forward),
        //           onTap: (){
        //             Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportPage()));
        //           },
        //         ),
        //       ),
        //     );
        //   },
        // ),
            :ListView(
          children: [
            // Card(
            //   color: Colors.lightGreen,
            //   elevation: 8.0,
            //   margin:
            //   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text("အဖွဲ့ဝင်များ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            //       ),
            //       Divider(
            //         color: Colors.white,
            //       ),
            //       ListView(
            //         shrinkWrap: true,
            //         physics: ScrollPhysics(),
            //         children: allMemberModelList.map((e) {
            //           return ListTile(
            //             // contentPadding: const EdgeInsets.symmetric(
            //             //     horizontal: 20.0, vertical: 10.0),
            //             leading: const Icon(Icons.account_circle,color: Colors.white,),
            //             title: Text(e.PersonName,style: TextStyle(color: Colors.white),),
            //             // trailing: const Icon(Icons.arrow_forward),
            //             onTap: (){
            //             },
            //           );
            //         }).toList(),
            //       ),
            //     ],
            //   ),
            // ),
            Card(
              elevation: 8.0,
              margin:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: ListTile(
                title: ExpansionTile(
                  title: Center(child: Text("အဖွဲ့ဝင်များ")),
                  children: allMemberModelList.map((e) {
                    return ListTile(
                      // contentPadding: const EdgeInsets.symmetric(
                      //     horizontal: 20.0, vertical: 10.0),
                      leading: const Icon(Icons.account_circle,color: Colors.lightGreen,),
                      title: Text(e.PersonName),
                      // trailing: const Icon(Icons.arrow_forward),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(Provider.of<UserProvider>(context,listen: false).userModel.UserID.toString(),e.PersonID,e.PersonName)));

                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            Card(
              elevation: 8.0,
              margin:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/icons/report_icon.ico"),
                ),
                title:Text("စာပို့ရန်"),
                trailing: Icon(Icons.arrow_forward),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportPage(
                      Provider.of<UserProvider>(context,listen: false).userModel.UserID.toString(),
                      groupid
                  )));

                },
              ),
            ),
            Card(
              elevation: 8.0,
              margin:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/icons/historical-report.png"),
                ),
                title:Text("တင်ပြချက်များ"),
                trailing: Icon(Icons.arrow_forward),
                onTap: (){
                  String uID = Provider.of<UserProvider>(context,listen: false).userModel.UserID.toString();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportHistoryPage(uID,groupid)));

                },
              ),
            ),
            Card(
              elevation: 8.0,
              margin:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/icons/sms_in.jpg"),
                  // child: Icon(Icons.folder_open),
                ),
                title:Text("ပြီးစီးမှုများ"),
                trailing: Icon(Icons.arrow_forward),
                onTap: (){

                  String uID = Provider.of<UserProvider>(context,listen: false).userModel.UserID.toString();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SuccessedReportHistoryPage(uID,groupid)));
                },
              ),
            ),
            Card(
              elevation: 8.0,
              margin:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/icons/Bokehlicia-Captiva-Chat-bubble.ico"),
                ),
                title:Text("စကားပြောခန်း"),
                trailing: Icon(Icons.arrow_forward),
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage()));
                },
              ),
            )

          ],
        ),
      ),
       floatingActionButton: Provider.of<UserProvider>(context,listen: false).userModel.UserID.toString() != "UserID" && (allMemberModelList.length == 0 && dataReturnStatus == true) ? FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.vpn_key),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewMemberPage()));
        },
      ):null,
    );
  }
}




class ConversationList extends StatefulWidget{
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  ConversationList({required this.name,required this.messageText,required this.imageUrl,required this.time,required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.messageText,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}

class Step {
  Step(
      this.title,
      this.body,
      [this.isExpanded = false]
      );
  String title;
  String body;
  bool isExpanded;
}