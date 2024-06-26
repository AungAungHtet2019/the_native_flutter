import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:the_native_flutter/view/pages/reported_case/report_detail_page.dart';

import '../../../model/report_history_model.dart';
import '../../../provider/report_history_provider.dart';
import '../../../provider/user_provider.dart';
import '../../../utils/dialogue.dart';
import '../../../utils/rest_api.dart';
import 'case_reply_page.dart';
import 'user/report_history_by_user_page.dart';

class ReportHistoryPage extends StatefulWidget {

  String userID;
  String groupID;

  ReportHistoryPage(
      this.userID,
      this.groupID
      );

  @override
  State<ReportHistoryPage> createState() => _ReportHistoryPageState();
}

class _ReportHistoryPageState extends State<ReportHistoryPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatId = "";

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  List<ReportHistory> reportHistoryModel = [];
  bool dataReturnStatus = false;
  int count = 1;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    setState(() {
      count = 1;
    });
    Provider.of<ReportHistoryProvider>(context,listen: false).getReportHistoryPagination(widget.groupID,count.toString());
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    if(mounted)
      setState(() {
        if(count < Provider.of<ReportHistoryProvider>(context,listen: false).last_page!){
          count ++;
        }

      });
    print("count is ");
    print(count);
    Provider.of<ReportHistoryProvider>(context,listen: false).getReportHistoryPagination(widget.groupID,count.toString());
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }


  // get_report_history()async{
  //
  //   List<ReportHistory> rawReportHistoryModel = await Provider.of<ReportHistoryProvider>(context,listen: false).get_report_history(widget.userID);
  //   setState(() {
  //     reportHistoryModel.clear();
  //     reportHistoryModel = rawReportHistoryModel;
  //   });
  //
  //   // Map body={
  //   //   'data':widget.userID,
  //   // };
  //   // var jsonbody = json.encode(body);
  //   // await ApiService.getReportHistory(jsonbody).then((success) {
  //   //   print("++++++++++++++++++++++++"+success.toString());
  //   //   print("***********************");
  //   //   List<dynamic> list = json.decode(success);
  //   //   print("getReportHistory data is "+list.toString());
  //   //   // setState(() {
  //   //   //   List<ReportHistoryModel> _alist = list.map((e) {
  //   //   //     return ReportHistoryModel.fromJson(e);
  //   //   //   }).toList();
  //   //   //   reportHistoryModel = _alist;
  //   //   //   dataReturnStatus = true;
  //   //   // });
  //   //
  //   //   setState(() {
  //   //     for(int i = 0 ; i < list.length;i++){
  //   //       try{
  //   //         reportHistoryModel.add(ReportHistory.fromJson(list[i]));
  //   //         print("hello"+i.toString());
  //   //         print(reportHistoryModel[i].CaseSubject);
  //   //       }
  //   //       catch(exp){
  //   //
  //   //       }
  //   //     }
  //   //     dataReturnStatus = true;
  //   //   });
  //   //
  //   //   reportHistoryModel.map((e) {
  //   //     return print(e.CaseSubject);
  //   //   }).toList();
  //   //
  //   // });
  //
  //
  // }

  // showDialogBox(String caseId,List<CaseReplied> caseReplied){
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //         elevation: 16,
  //         // child: Container(
  //         //   child: ListView(
  //         //     shrinkWrap: true,
  //         //     children: <Widget>[
  //         //       SizedBox(height: 20),
  //         //       Center(child: Text('Leaderboard')),
  //         //       SizedBox(height: 20),
  //         //       // _buildRow('assets/choc.png', 'Name 1', 1000),
  //         //       // _buildRow('assets/choc.png', 'Name 2', 2000),
  //         //       // _buildRow('assets/choc.png', 'Name 3', 3000),
  //         //       // _buildRow('assets/choc.png', 'Name 4', 4000),
  //         //       // _buildRow('assets/choc.png', 'Name 5', 5000),
  //         //       // _buildRow('assets/choc.png', 'Name 6', 6000),
  //         //     ],
  //         //   ),
  //         // ),
  //         child: SafeArea(
  //           child: WillPopScope(
  //             child: Stack(
  //               children: <Widget>[
  //                 Column(
  //                   children: <Widget>[
  //                     // List of messages
  //                     Expanded(
  //                       child:ListView(
  //                         children: caseReplied.map((e) {
  //                           return Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Row(
  //                               children: [
  //                                 e.CreatedBy != e.PersonID? Container(
  //                                   height: 40,
  //                                   width: 40,
  //                                   child: CircleAvatar(
  //                                     radius: 70.0,
  //                                     backgroundImage: AssetImage('assets/images/profile-unknown.png'),
  //                                     backgroundColor: Colors.white,
  //                                   ),
  //                                 ):Container(),
  //                                 Flexible(
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.all(8.0),
  //                                     child: Column(
  //                                       children: [
  //                                         Card(
  //                                           elevation: 5,
  //                                           child: Padding(
  //                                             padding: const EdgeInsets.all(18.0),
  //                                             child: ListTile(
  //                                               title: Text(e.RepliedBody),
  //                                               subtitle: Text(e.CreatedDate),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 e.CreatedBy == e.PersonID? Container(
  //                                   height: 40,
  //                                   width: 40,
  //                                   child: CircleAvatar(
  //                                     radius: 70.0,
  //                                     backgroundImage: AssetImage('assets/images/profile-unknown.png'),
  //                                     backgroundColor: Colors.white,
  //                                   ),
  //                                 ):Container(),
  //                               ],
  //                             ),
  //                           );
  //                         }).toList(),
  //
  //                       )
  //                     ),
  //
  //
  //
  //                     // Input content
  //                     Container(
  //                       child: Row(
  //                         children: <Widget>[
  //                           // Button send image
  //                           // Material(
  //                           //   child: Container(
  //                           //     margin: EdgeInsets.symmetric(horizontal: 1),
  //                           //     child: IconButton(
  //                           //       icon: Icon(Icons.image),
  //                           //       onPressed: (){
  //                           //
  //                           //       },
  //                           //
  //                           //     ),
  //                           //   ),
  //                           //   color: Colors.white,
  //                           // ),
  //                           // Material(
  //                           //   child: Container(
  //                           //     margin: EdgeInsets.symmetric(horizontal: 1),
  //                           //     child: IconButton(
  //                           //       icon: Icon(Icons.face),
  //                           //       onPressed: (){
  //                           //
  //                           //       },
  //                           //
  //                           //     ),
  //                           //   ),
  //                           //   color: Colors.white,
  //                           // ),
  //
  //                           // Edit text
  //                           Flexible(
  //                             child: Padding(
  //                               padding: const EdgeInsets.only(left: 8.0),
  //                               child: Container(
  //                                 child: TextField(
  //                                   onSubmitted: (value) {
  //
  //                                   },
  //                                   style: TextStyle( fontSize: 15),
  //                                   controller: textEditingController,
  //                                   decoration: InputDecoration.collapsed(
  //                                     hintText: 'Type your message...',
  //                                   ),
  //                                   focusNode: focusNode,
  //                                   autofocus: true,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //
  //                           // Button send message
  //                           Material(
  //                             child: Container(
  //                               margin: EdgeInsets.symmetric(horizontal: 8),
  //                               child: IconButton(
  //                                 icon: Icon(Icons.send),
  //                                 onPressed: (){
  //                                   if(textEditingController.text != ""){
  //                                     insertCaseReply(caseId,textEditingController.text);
  //                                   }
  //                                   else{
  //                                     Navigator.of(context).pop();
  //                                   }
  //                                 },
  //
  //                               ),
  //                             ),
  //                             color: Colors.white,
  //                           ),
  //                         ],
  //                       ),
  //                       width: double.infinity,
  //                       height: 50,
  //                       decoration: BoxDecoration(
  //                           border: Border(top: BorderSide( width: 0.5)), color: Colors.white),
  //                     ),
  //                   ],
  //                 ),
  //
  //                 // Loading
  //                 buildLoading()
  //               ],
  //             ),
  //             onWillPop: onBackPress,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // insertCaseReply(String caseID,String caseBody)async{
  //
  //   Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
  //   Map body = {
  //     "Case_ID":"$caseID",
  //     "Replied_Body":"$caseBody",
  //   };
  //
  //   var jsonbody = json.encode(body);
  //
  //   await ApiService.createCaseReply(jsonbody).then((value) {
  //     print(value);
  //     Navigator.of(context).pop();//to close loading dialog
  //     if(value !="NoOK")
  //     {
  //       statusDialog("Replied Ok");
  //     }
  //     else{
  //       statusDialog("Pleas try again.");
  //     }
  //
  //
  //   });
  //
  //   // Provider.of<ReportHistoryProvider>(context,listen: false).get_report_history(widget.userID);
  // }
  //
  // void statusDialog(String title) {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return CupertinoAlertDialog(
  //         title: new Text("The Native "),
  //         content: Padding(
  //           padding: const EdgeInsets.only(top:15.0),
  //           child: new Text(title),
  //         ),
  //         actions: <Widget>[
  //           // CupertinoDialogAction(
  //           //   isDefaultAction: true,
  //           //   child: Text("This phone number is already registered",style: TextStyle(color: Colors.red,fontSize: 12.0)),
  //           // ),
  //           new TextButton(
  //             child: new Text("OK"),
  //             onPressed: () {
  //               Navigator.pop(context);
  //               Navigator.pop(context);
  //
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // get_report_history();
    // Provider.of<ReportHistoryProvider>(context,listen: false).getReportHistory(widget.groupID);
    Provider.of<ReportHistoryProvider>(context,listen: false).getReportHistoryPagination(widget.groupID,count.toString());


  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("တင်ပြချက်များ",style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.lightGreen,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Provider.of<ReportHistoryProvider>(context,listen: true).ReportHistoryModel.length == 0  && Provider.of<ReportHistoryProvider>(context,listen: true).DataReturnStatus == false ? ListView.builder(
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
            :Provider.of<ReportHistoryProvider>(context,listen: true).ReportHistoryModel.length == 0 && Provider.of<ReportHistoryProvider>(context,listen: true).DataReturnStatus == true  ? Center(child: Text("No record found")):
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
                                  InkWell(
                                    onTap: (){



                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportHistoryByUserPage(
                                        userName: Provider.of<ReportHistoryProvider>(context,listen: false).ReportHistoryModel[index].PersonName,
                                        personId: Provider.of<ReportHistoryProvider>(context,listen: false).ReportHistoryModel[index].PersonID,
                                        groupId: widget.groupID,)));


                                    },
                                    child: Row(
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
                              Text(" "+Provider.of<ReportHistoryProvider>(context,listen: true).ReportHistoryModel[index].caseReplied.where((e) => e.PersonID != widget.userID).toList().length.toString()+" စောင်",style: TextStyle(fontWeight: FontWeight.bold),)

                            ],
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CaseReplyListPage(
                              widget.userID,
                              widget.groupID,
                              Provider.of<ReportHistoryProvider>(context,listen: false).ReportHistoryModel[index].CaseID,
                              Provider.of<ReportHistoryProvider>(context,listen: false).ReportHistoryModel[index].CaseSubject,
                              index)));
                          // showDialogBox(Provider.of<ReportHistoryProvider>(context,listen: false).reportHistoryModel[index].CaseID,Provider.of<ReportHistoryProvider>(context,listen: false).reportHistoryModel[index].caseReplied);
                        },
                      ),
                    ),
                    Divider(
                      height: 10,
                    )
                  ],
                ),
              );

            }),
      )
    );
  }

  Widget _buildRow(String imageAsset, String name, double score) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Container(height: 2, color: Colors.redAccent),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              CircleAvatar(backgroundImage: AssetImage(imageAsset)),
              SizedBox(width: 12),
              Text(name),
              Spacer(),
              Container(
                decoration: BoxDecoration(color: Colors.yellow[900], borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text('$score'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: SizedBox.shrink(),
    );
  }

  // Hide sticker or back
  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

}
