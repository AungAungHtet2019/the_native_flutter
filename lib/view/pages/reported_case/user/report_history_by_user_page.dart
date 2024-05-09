import 'package:flutter/material.dart';

class ReportHistoryByUserPage extends StatefulWidget {
  const ReportHistoryByUserPage({super.key});

  @override
  State<ReportHistoryByUserPage> createState() => _ReportHistoryByUserPageState();
}

class _ReportHistoryByUserPageState extends State<ReportHistoryByUserPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("တင်ပြချက်များ",style: TextStyle(color: Colors.white),)),
          backgroundColor: Colors.lightGreen,
        ),
        body: _mainWidget()
    );
  }

  Widget _mainWidget(){
    return Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList.length == 0  && Provider.of<ReportHistoryProvider>(context,listen: true).DataReturnStatus == false ? ListView.builder(
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
        :Provider.of<ReportHistoryProvider>(context,listen: true).reportHistoryByUserList.length == 0 && Provider.of<ReportHistoryProvider>(context,listen: true).DataReturnStatus == true  ? Center(child: Text("No record found")):
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
                                    child: Provider.of<ReportHistoryProvider>(context,listen: false).reportHistoryByUserList[index].UserProfilePicture == "User_Profile_Picture" ? CircleAvatar(
                                      radius: 70.0,
                                      backgroundImage: AssetImage('assets/images/profile-unknown.png'),
                                      backgroundColor: Colors.white,
                                    ):ClipRRect(
                                      borderRadius: BorderRadius.circular(800),
                                      child: CachedNetworkImage(
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                        imageUrl: Provider.of<ReportHistoryProvider>(context,listen: false).reportHistoryByUserList[index].DomainName+Provider.of<ReportHistoryProvider>(context,listen: false).reportHistoryByUserList[index].UserProfilePicture,
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
  }
}
