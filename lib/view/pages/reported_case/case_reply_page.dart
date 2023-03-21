import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

import '../../../model/case_replied_model.dart';
import '../../../provider/report_history_provider.dart';
import '../../../utils/dialogue.dart';
import '../../../utils/rest_api.dart';
import '../../widgets/files_widget.dart';
import '../../widgets/photo_view_case_replied_file_widget.dart';
import '../../widgets/photo_view_widget.dart';
import '../../widgets/reply_file_widget.dart';
import 'package:url_launcher/url_launcher.dart';


class CaseReplyListPage extends StatefulWidget {
  String userID;
  String groupId;
  String caseId;
  String caseTitle;
  int myIndex;
  // List<CaseReplied> caseReplied;
  CaseReplyListPage(
      this.userID,
      this.groupId,
      this.caseId,
      this.caseTitle,
      // this.caseReplied
      this.myIndex
      );

  @override
  State<CaseReplyListPage> createState() => _CaseReplyListPageState();
}

class _CaseReplyListPageState extends State<CaseReplyListPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isShowSticker = false;

  var resultFiels;
  List<PlatformFile> images = [];
  List<PlatformFile> files = [];
  List resultList = [];

  insertCaseReply(String caseID,String caseBody)async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
    Map body = {
      "Case_ID":"$caseID",
      "Reply_User_ID":widget.userID,"Replied_Body":"$caseBody",
    };

    var jsonbody = json.encode(body);

    await ApiService.createCaseReply(jsonbody).then((value) {
      print(value);

      if(value !="NoOK")
      {
        //statusDialog("Replied Ok");
        textEditingController.clear();
        _submit(value);
        Provider.of<ReportHistoryProvider>(context,listen: false).getReportHistory(widget.groupId);

      }
      else{
        // Navigator.pop(context);
        statusDialog("Pleas try again.");
      }
    });

  }

  closeCaseFile(String caseID)async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
    Map body = {
      "Data":"$caseID",
    };

    var jsonbody = json.encode(body);

    await ApiService.closeCaseFile(jsonbody).then((value) {
      print(value);

      if(value !="nook")
      {
        statusDialog("ဖိုင်ပိတ်သိမ်းမှုအောင်မြင်ပါသည်။");
        Provider.of<ReportHistoryProvider>(context,listen: false).getReportHistory(widget.groupId);

      }
      else{
        statusDialog("Pleas try again.");
      }


    });

  }


  void statusDialog(String title) {
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

                setState(() {
                  resultFiels = null;
                  images.clear();
                  files.clear();
                  resultList.clear();
                });
              },
            )
          ],
        );
      },
    );
  }

  void closeCaseFileConfirmDialog() {
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
            child: new Text("ဖိုင်ပိတ်သိမ်းမည်မှာသေချာပါသလား ? "),
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
                closeCaseFile(widget.caseId);

              },
            )
          ],
        );
      },
    );
  }


  void openFile(PlatformFile file){
    OpenFile.open(file.path);
  }

  _submit(String cReplyID) async {
    // Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    String folderName = DateTime.now().microsecondsSinceEpoch.toString()+"/";
    for (int i = 0; i < images.length; i++) {
      // var path2 = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      var path2 = await images[i].path;
      print(path2);
      print("MyPath");
      // final file = images[i];
      // PlatformFile file = images[i];
      final bytes = await File(path2!).readAsBytesSync();
      // print(bytes);
      String img64 = base64Encode(bytes!);
      print(img64);


      Map body={
        "userID":widget.userID,
        'caseID':cReplyID,
        'case_File_Size':images[i].size.toString(),
        'folderName':folderName,
        'fileName':images[i].name,
        'base64': img64,
      };
      var jsonbody = json.encode(body);
      await ApiService.replyFileUpload(jsonbody).then((success) {
        print("++++++++++++++++++++++++"+success.toString());
        print("***********************");
      });

    }
    // Navigator.pop(context);
    statusDialog("Replied Ok");
  }

  final Uri _url = Uri.parse('https://flutter.dev');

  Future<void> _launchUrl(Uri _url) async {
    print(_url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.caseTitle,style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.lightGreen,
         actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    child: InkWell(
                        splashColor: Colors.grey, // splash color
                        child: widget.userID != Provider.of<ReportHistoryProvider>(context,listen: false).ReportHistoryModel[widget.myIndex].PersonID? Text(""): Text('လုပ်ငန်းပြီးဆုံးကြောင်းအတည်ပြုသည်',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                      onTap: (){
                         closeCaseFileConfirmDialog();
                      },
                    )
                ),
                // PopupMenuItem(
                //     child: InkWell(
                //         splashColor: Colors.grey, // splash color
                //         child: Text('Bookmarks')
                //     )
                // ),
                // PopupMenuItem(
                //     child: InkWell(
                //         splashColor: Colors.grey, // splash color
                //         child: Text('Seeting')
                //     )
                // ),
              ];
            },
          )
        ],
      ),

      body: SafeArea(
        child: WillPopScope(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  // List of messages
                  Expanded(
                      child:ListView(
                        children: Provider.of<ReportHistoryProvider>(context,listen: true).ReportHistoryModel[widget.myIndex].caseReplied.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    // e.gUserName.length > 0 ? Container(
                                    //   height: 40,
                                    //   width: 40,
                                    //   child: CircleAvatar(
                                    //     radius: 70.0,
                                    //     backgroundImage: AssetImage('assets/images/logo.jpg'),
                                    //     backgroundColor: Colors.white,
                                    //   ),
                                    // ):Container(),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          elevation: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Column(
                                              children: [
                                                e.gUserName != "G_User_Name" ? Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      child: CircleAvatar(
                                                        radius: 70.0,
                                                        backgroundImage: AssetImage('assets/images/logo.jpg'),
                                                        backgroundColor: Colors.white,
                                                      ),
                                                    ),
                                                     Padding(
                                                       padding: const EdgeInsets.all(8.0),
                                                       child: Text(e.gUserName),
                                                     ),
                                                  ],
                                                ):
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      child:e.UserProfilePicture == "User_Profile_Picture" ? CircleAvatar(
                                                        radius: 70.0,
                                                        backgroundImage: AssetImage('assets/images/profile-unknown.png'),
                                                        backgroundColor: Colors.white,
                                                      ):ClipRRect(
                                                        borderRadius: BorderRadius.circular(800),
                                                        child: CachedNetworkImage(
                                                          width: 40,
                                                          height: 40,
                                                          fit: BoxFit.cover,
                                                          imageUrl: e.DomainName+e.UserProfilePicture,
                                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                              CircularProgressIndicator(value: downloadProgress.progress),
                                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(e.UserName),
                                                    ),
                                                  ],
                                                ),
                                                ListTile(
                                                  subtitle: Text((e.CreatedDate.replaceAll("T", " ")).split(".")[0]),
                                                ),
                                                ListTile(
                                                  title: Text(e.RepliedBody),
                                                ),
                                                e.caseRepliedFile.length > 0 ?Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  // child: GridView.builder(
                                                  //     physics: ScrollPhysics(),
                                                  //     shrinkWrap: true,
                                                  //     padding: EdgeInsets.all(16),
                                                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                  //         crossAxisCount: 2,
                                                  //         mainAxisSpacing: 8,
                                                  //         crossAxisSpacing: 8
                                                  //     ),
                                                  //     itemCount: widget.reportHistoryModel.caseFile.length,
                                                  //     itemBuilder: (context,index) {
                                                  //       // final file = widget.files[index];
                                                  //       // return buildFile(file);
                                                  //       return InkWell(
                                                  //         child: Container(
                                                  //           padding: EdgeInsets.all(8),
                                                  //           child: Column(
                                                  //             children: [
                                                  //               Expanded(
                                                  //                 child:widget.reportHistoryModel.caseFile[index].CaseFileExtension == 'pdf' ? Image.asset('assets/icons/pdf_icon.png'):
                                                  //                 // Image.network(caseFileList[index].CaseFilePath),
                                                  //                 CachedNetworkImage(
                                                  //                   imageUrl: widget.reportHistoryModel.caseFile[index].CaseFilePath,
                                                  //                   imageBuilder: (context, imageProvider) => Container(
                                                  //                     decoration: BoxDecoration(
                                                  //                       image: DecorationImage(
                                                  //                           image: imageProvider,
                                                  //                           fit: BoxFit.cover,
                                                  //                           // colorFilter:
                                                  //                           // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                  //                       ),
                                                  //                     ),
                                                  //                   ),
                                                  //                   placeholder: (context, url) => Center(
                                                  //                     child: Container(
                                                  //                       width: 10,
                                                  //                         height: 10,
                                                  //                         child: Center(child: CircularProgressIndicator())),
                                                  //                   ),
                                                  //                   errorWidget: (context, url, error) => Icon(Icons.error),
                                                  //                 ),
                                                  //               ),
                                                  //               // Expanded(
                                                  //               //     child: Text(caseFileList[index].CaseFileName)),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //         onTap: (){
                                                  //           _launchUrl(Uri.parse(widget.reportHistoryModel.caseFile[index].CaseFilePath));
                                                  //         },
                                                  //       );
                                                  //     }
                                                  // ),
                                                  child:StaggeredGridView.countBuilder(
                                                      physics: ScrollPhysics(),
                                                      shrinkWrap: true,
                                                      mainAxisSpacing: 10,
                                                      crossAxisSpacing: 8,
                                                      crossAxisCount: 4,
                                                      itemCount: e.caseRepliedFile.length,
                                                      itemBuilder: (context, index) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                                            color: Colors.transparent,
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                                            child:e.caseRepliedFile[index].CaseRepliedFileExtension == '.pdf' ? InkWell(
                                                                onTap: (){
                                                                  _launchUrl(Uri.parse(e.caseRepliedFile[index].DomainName+e.caseRepliedFile[index].CaseRepliedFilePath));
                                                                },
                                                                child: Image.asset('assets/icons/pdf_icon.png')
                                                            ):
                                                            // Image.network(caseFileList[index].CaseFilePath),
                                                            InkWell(
                                                              child: CachedNetworkImage(
                                                                imageUrl: e.caseRepliedFile[index].DomainName+e.caseRepliedFile[index].CaseRepliedFilePath,
                                                                imageBuilder: (context, imageProvider) => Container(
                                                                  decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: imageProvider,
                                                                      fit: BoxFit.cover,
                                                                      // colorFilter:
                                                                      // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                                    ),
                                                                  ),
                                                                ),
                                                                placeholder: (context, url) => Center(
                                                                  child: Container(
                                                                      width: 10,
                                                                      height: 10,
                                                                      child: Center(child: CircularProgressIndicator())),
                                                                ),
                                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                                              ),
                                                              onTap: (){
                                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> PhotoViewCaseRepliedFileWidget(e.caseRepliedFile)));

                                                              },
                                                            ),
                                                          ),
                                                          // Expanded(
                                                          //     child: Text(caseFileList[index].CaseFileName)),
                                                        );
                                                      },
                                                      staggeredTileBuilder: (index) {
                                                        return StaggeredTile.count(1, index.isEven ? 1.4 : 1.9);
                                                      }),
                                                ):Container(
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      )
                  ),

                  // Input content
                  Container(
                    child: Row(
                      children: <Widget>[
                        // Button send image
                        Material(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1),
                            child: IconButton(
                              icon: Icon(Icons.image),
                              onPressed: () async {
                                final resultList = await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.custom,
                                  allowedExtensions: ['png','jpg','jpeg','pdf'],
                                );
                                setState(() {
                                  resultFiels = resultList;
                                });

                                print(resultList);
                                images = resultFiels.files;
                                print(images.length);
                                print("ok");
                              },

                            ),
                          ),
                          color: Colors.white,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              child: TextField(
                                onSubmitted: (value) {

                                },
                                style: TextStyle( fontSize: 15),
                                controller: textEditingController,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Type your message...',
                                ),
                                // focusNode: focusNode,
                                // autofocus: true,
                              ),
                            ),
                          ),
                        ),

                        // Button send message
                        Material(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: (){
                                if(textEditingController.text != ""){
                                  insertCaseReply(widget.caseId,textEditingController.text);
                                }
                                else{
                                  Navigator.of(context).pop();
                                }
                              },

                            ),
                          ),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide( width: 0.5)), color: Colors.white),
                  ),
                  if(resultFiels != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: Stack(
                              children: [
                                Card(
                                  // color: Colors.white54,
                                  child: ReplyFilesWidget(
                                    files: resultFiels.files,
                                    onOpenedFile: openFile,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment(1.05, -0.95),
                                  child: InkWell(
                                    onTap: () {

                                      setState(() {
                                        resultFiels = null;
                                        images.clear();
                                        files.clear();
                                        resultList.clear();
                                      });
                                    },
                                    child: Container(
                                      width: 20.0,
                                      height: 20.0,
                                      child: Icon(Icons.close, color: Colors.red, size: 20,),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(color: Colors.black,offset: Offset(0, 1), blurRadius: 2),
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              // Loading
              buildLoading()
            ],
          ),
          onWillPop: onBackPress,
        ),
      )
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
