import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/case_file_model.dart';
import '../../model/report_history_model.dart';
import '../../utils/rest_api.dart';
import '../widgets/photo_view_widget.dart';

class ReportDetailPage extends StatefulWidget {

  ReportHistory reportHistoryModel;
  // String caseID;

  ReportDetailPage(this.reportHistoryModel
      // ,this.caseID
      );

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {

  // List<CaseFile> caseFileList = [];
  // bool dataReturnStatus = false;

  // getCaseFileList()async{
  //
  //   Map body={
  //     'caseID':widget.caseID,
  //   };
  //   var jsonbody = json.encode(body);
  //   await ApiService.getCaseFileList(jsonbody).then((success) {
  //     print("++++++++++++++++++++++++"+success.toString());
  //     print("***********************");
  //     List<dynamic> list = json.decode(success);
  //     print("getCaseFileList data is "+list.toString());
  //
  //     setState(() {
  //       for(int i = 0 ; i < list.length;i++){
  //         try{
  //           caseFileList.add(CaseFile.fromJson(list[i]));
  //           print("hello"+i.toString());
  //           print(caseFileList[i].CaseFileName);
  //         }
  //         catch(exp){
  //
  //         }
  //       }
  //       dataReturnStatus = true;
  //     });
  //
  //     caseFileList.map((e) {
  //       return print(e.CaseFileName);
  //     }).toList();
  //
  //   });
  //
  //
  // }


  final Uri _url = Uri.parse('https://flutter.dev');

  Future<void> _launchUrl(Uri _url) async {
    print(_url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // getCaseFileList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Center(child: Text("Report Detail",style: TextStyle(color: Colors.white),)),
    //     backgroundColor: Colors.lightGreen,
    //   ),
    //   body: ListView(
    //     children: [
    //       Center(
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Text(widget.reportHistoryModel.CaseSubject,style: TextStyle(fontWeight: FontWeight.bold),),
    //           )),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(widget.reportHistoryModel.CaseBody),
    //       ),
    //       widget.reportHistoryModel.caseFile.length > 0 ?Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Card(
    //           // color: Colors.white30,
    //           child: GridView.builder(
    //             physics: ScrollPhysics(),
    //             shrinkWrap: true,
    //               padding: EdgeInsets.all(16),
    //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                   crossAxisCount: 2,
    //                   mainAxisSpacing: 8,
    //                   crossAxisSpacing: 8
    //               ),
    //               itemCount: widget.reportHistoryModel.caseFile.length,
    //               itemBuilder: (context,index) {
    //                 // final file = widget.files[index];
    //                 // return buildFile(file);
    //                 return InkWell(
    //                   child: Container(
    //                     padding: EdgeInsets.all(8),
    //                     child: Column(
    //                       children: [
    //                         Expanded(
    //                             child:widget.reportHistoryModel.caseFile[index].CaseFileExtension == 'pdf' ? Image.asset('assets/icons/pdf_icon.png'):Image.network(widget.reportHistoryModel.caseFile[index].CaseFilePath),
    //                         ),
    //                         Expanded(
    //                             child: Text(widget.reportHistoryModel.caseFile[index].CaseFileName)),
    //                       ],
    //                     ),
    //                   ),
    //                   onTap: (){
    //                     _launchUrl(Uri.parse(widget.reportHistoryModel.caseFile[index].CaseFilePath));
    //                   },
    //                 );
    //               }
    //           ),
    //         ),
    //       ):Container(),
    //       // ListView(
    //       //   shrinkWrap: true,
    //       //   physics: ScrollPhysics(),
    //       //   children: widget.reportHistoryModel.caseFile.map((e) {
    //       //     return e.CaseFileExtension == 'pdf' ?  Image.asset('assets/icons/pdf_icon.png'):Image.network(e.CaseFilePath);
    //       //   }).toList()
    //       // )
    //     ],
    //   ),
    // );
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: [
        // Center(
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Text(widget.reportHistoryModel.CaseSubject,style: TextStyle(fontWeight: FontWeight.bold),),
        //     )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.reportHistoryModel.CaseBody),
        ),
        widget.reportHistoryModel.caseFile.length > 0 ?Padding(
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
              crossAxisCount: 2,
              itemCount: widget.reportHistoryModel.caseFile.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    child:widget.reportHistoryModel.caseFile[index].CaseFileExtension == 'pdf' ? InkWell(
                                        onTap: (){
                                          // _launchUrl(Uri.parse(widget.reportHistoryModel.caseFile[index].DomainName+widget.reportHistoryModel.caseFile[index].CaseFilePath,));
                                          _launchUrl(Uri.parse(widget.reportHistoryModel.caseFile[index].DomainName+widget.reportHistoryModel.caseFile[index].CaseFilePath));
                                        },
                                        child: Image.asset('assets/icons/pdf_icon.png')
                                    ):
                                    InkWell(
                                      child: CachedNetworkImage(
                                        imageUrl: widget.reportHistoryModel.caseFile[index].DomainName+widget.reportHistoryModel.caseFile[index].CaseFilePath,
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PhotoViewWidget(widget.reportHistoryModel.caseFile)));
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
        ):Container(),
        // ListView(
        //   shrinkWrap: true,
        //   physics: ScrollPhysics(),
        //   children: widget.reportHistoryModel.caseFile.map((e) {
        //     return e.CaseFileExtension == 'pdf' ?  Image.asset('assets/icons/pdf_icon.png'):Image.network(e.CaseFilePath);
        //   }).toList()
        // )
      ],
    );
  }
}
