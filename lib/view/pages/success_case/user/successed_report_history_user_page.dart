import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/report_history_provider.dart';
import '../../../../provider/successed_report_history_provider.dart';
import '../../reported_case/report_detail_page.dart';

class SuccessedReportHistoryByUserPage extends StatefulWidget {
  String userName;
  String personId;
  String groupId;

  SuccessedReportHistoryByUserPage({super.key,required this.userName, required this.personId,required this.groupId});

  @override
  State<SuccessedReportHistoryByUserPage> createState() => _SuccessedReportHistoryByUserPageState();
}

class _SuccessedReportHistoryByUserPageState extends State<SuccessedReportHistoryByUserPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _init();

  }

  void _init(){
    Future.delayed(Duration.zero, (){
      selectSuccessedReportHistoryByUser(personId: widget.personId, groupId: widget.groupId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.userName,style: TextStyle(color: Colors.white),)),
          backgroundColor: Colors.lightGreen,
        ),
        body: _mainWidget()
    );
  }

  Widget _mainWidget(){
    final Size size = MediaQuery.of(context).size;
    return Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList.length == 0  && Provider.of<ReportHistoryProvider>(context,listen: true).getReportHistoryByUserStatus == false ? ListView.builder(
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
        :Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList.length == 0 && Provider.of<ReportHistoryProvider>(context,listen: true).getReportHistoryByUserStatus == true  ? Center(child: Text("No record found")):
    ListView.builder(
        itemCount: Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList.length,
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
                                    child: Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList[index].UserProfilePicture == "User_Profile_Picture" ? CircleAvatar(
                                      radius: 70.0,
                                      backgroundImage: AssetImage('assets/images/profile-unknown.png'),
                                      backgroundColor: Colors.white,
                                    ):ClipRRect(
                                      borderRadius: BorderRadius.circular(800),
                                      child: CachedNetworkImage(
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                        imageUrl: Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList[index].DomainName+Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList[index].UserProfilePicture,
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
                                                Text(Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList[index].PersonName,style: TextStyle(fontWeight: FontWeight.bold),),
                                                Row(
                                                  children: [
                                                    Text((Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList[index].CreatedDate.replaceAll("T", " ")).split(".")[0]),
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

                Text(Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList[index].CaseSubject,style: TextStyle(fontWeight: FontWeight.bold),),
                ReportDetailPage(Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList[index]
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
                          Text(" "+Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList[index].caseReplied.where((e) => e.PersonID != widget.personId).toList().length.toString()+" စောင်",style: TextStyle(fontWeight: FontWeight.bold),)

                        ],
                      ),
                    ),
                    onTap: (){
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

        });
  }

  void selectSuccessedReportHistoryByUser({required String personId, required String groupId}) async{
    bool status = await Provider.of<SuccessedReportHistoryProvider>(context,listen: false).getSuccessedReporReportHistoryByUser(personId: personId, groupId: groupId);
  }


}
