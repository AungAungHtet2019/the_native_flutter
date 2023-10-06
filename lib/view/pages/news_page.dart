import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:the_native_flutter/model/news_model.dart';
import 'package:the_native_flutter/text_description.dart';
import 'package:the_native_flutter/utils/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'news_detail_page.dart'; //For Http Pages



class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
   List<WpContent> newsModelList = [];
   bool getNewsStatus = true;
   int pageIndex = 1;

  _getData(int myPageIndex) async {

    var response = await http.get(Uri.parse(apiEndpointNews+"&page="+myPageIndex.toString()));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');




    try{

      List<dynamic> dataList =
      jsonDecode(response.body); // list of wp-content
      for (int i = 0; i < dataList.length; i++) {
        if (newsModelList == null) {
          newsModelList = [];
        }
        setState(() {
          newsModelList.add(WpContent.fromJson(dataList[i]));
        });
      }
    }
    catch(exp){
      setState(() {
        getNewsStatus = false;

      });
      print("Hello");
      print(exp);
    }

  }

   void _onRefresh() async{

     setState(() {
       pageIndex =1;
       newsModelList = [];
     });
     _getData(pageIndex);
     // monitor network fetch
     await Future.delayed(Duration(milliseconds: 1000));
     // if failed,use refreshFailed()
     _refreshController.refreshCompleted();
   }

   void _onLoading() async{

    setState(() {
      pageIndex +=1;
    });
    _getData(pageIndex);
     // monitor network fetch
     await Future.delayed(Duration(milliseconds: 1000));
     // if failed,use loadFailed(),if no data return,use LoadNodata()
     // items.add((items.length+1).toString());
     if(mounted)
       setState(() {

       });
     _refreshController.loadComplete();
   }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;


    return Scaffold(
      body: newsModelList.length == 0 && getNewsStatus == true ? ListView.builder(
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
      ): newsModelList.length == 0 && getNewsStatus == false ? Center(
        child: Text("No data"),
      ) :
      SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
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
        onLoading: _onLoading,
            child: ListView(
        children: newsModelList.map((e) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailPage( title: e.title.rendered,contentText: e.content.rendered)));
              },
              child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myWidget(
                        'https://www.westernunion.com/content/dam/wu/jm/responsive/send-money-in-person-from-jamaica-resp.png',
                        e.modified,
                        e.title.rendered,
                        //'Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.',
                        // 'https://cloudfront-us-east-2.images.arcpublishing.com/reuters/4YJSBO3FOBLWZOBLAIHII2SXSA.jpg',
                      // e.embedded.featuredmedia[0].sourceUrl,
                      // e.content.rendered,

                      e.embedded.featuredmedia[0].sourceUrl,
                      e.content.rendered,

                    ),
                  )),
            );
        }).toList(),
      ),
          ),
    );
  }

  myWidget(String profileUrl,String profileName,String title,String photoUrl,String contentText){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(left: 18.0, top: 10),
        //       child: Material(
        //         elevation: 10,
        //         borderRadius: BorderRadius.circular(140),
        //         child: Container(
        //           decoration: new BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(140)),
        //           height: 58,
        //           width: 60,
        //           child: Stack(
        //             children: <Widget>[
        //               Container(
        //                   height: 78,
        //                   width: 74,
        //                   margin: const EdgeInsets.only(
        //                       left: 0.0, right: 0, top: 0, bottom: 0),
        //                   padding: const EdgeInsets.all(0),
        //                   decoration: BoxDecoration(
        //                       border: Border.all(color: Colors.white, width: 2),
        //                       borderRadius: BorderRadius.circular(140)),
        //                   child: CircleAvatar(
        //                     backgroundImage: NetworkImage(
        //                       // 'https://bloximages.newyork1.vip.townnews.com/roanoke.com/content/tncms/assets/v3/editorial/d/da/ddac1f83-ffae-5e84-a8e5-e71f8ff18119/5f3176da21b5c.image.jpg?crop=650%2C650%2C175%2C0&resize=1200%2C1200&order=crop%2Cresize',
        //                       profileUrl,
        //                     ),
        //                   )),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //       Padding(
        //         padding: const EdgeInsets.only(left: 15.0, top: 13),
        //         child: Text(
        //           // 'Sound Byte',
        //           profileName,
        //           style: GoogleFonts.lato(
        //               color: Colors.grey[700],
        //               fontSize: 16,
        //               letterSpacing: 1,
        //               fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 16.0),
        //         child: Text(
        //           '1 hr',
        //           style: GoogleFonts.lato(
        //               color: Colors.grey[500],
        //               fontSize: 15,
        //               letterSpacing: 1,
        //               fontWeight: FontWeight.normal),
        //         ),
        //       ),
        //     ]),
        //   ],
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
          // child: Text(
          //   // 'Was great meeting up with Anna Ferguson and Dave Bishop at the breakfast talk!',
          //   this.title,
          //   style: GoogleFonts.lato(
          //       color: Colors.grey[600],
          //       fontSize: 15,
          //       letterSpacing: 1,
          //       fontWeight: FontWeight.normal),
          //   textAlign: TextAlign.justify,
          // ),
          child: new DescriptionTextWidget(text: title),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
          child: Text(profileName),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 18.0, right: 18, top: 15),
        //   child: Material(
        //       borderRadius: BorderRadius.all(Radius.circular(40)),
        //       elevation: 6,
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(10),
        //         ),
        //         child: Image.network(
        //             // 'https://images.pexels.com/photos/2387873/pexels-photo-2387873.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
        //             this.photoUrl),
        //       )),
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 15),
          child: Material(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              elevation: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: photoUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        //   // child: Text(
        //   //   // 'Was great meeting up with Anna Ferguson and Dave Bishop at the breakfast talk!',
        //   //   this.title,
        //   //   style: GoogleFonts.lato(
        //   //       color: Colors.grey[600],
        //   //       fontSize: 15,
        //   //       letterSpacing: 1,
        //   //       fontWeight: FontWeight.normal),
        //   //   textAlign: TextAlign.justify,
        //   // ),
        //   child: new DescriptionTextWidget(text: contentText),
        // ),
        // Html(
        //   data: """
        //         $contentText
        //         """,
        //   padding: EdgeInsets.all(8.0),
        //   onLinkTap: (url) {
        //     print("Opening $url...");
        //   },
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(top: 2, left: 28.0),
        //       child: Row(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.only(right: 5.0),
        //             child: Image.asset(
        //               'assets/images/like.png',
        //               height: 35,
        //             ),
        //           ),
        //           Text(
        //             '45',
        //             style: GoogleFonts.averageSans(
        //                 color: Colors.grey[700],
        //                 fontSize: 22,
        //                 letterSpacing: 1,
        //                 fontWeight: FontWeight.normal),
        //           ),
        //         ],
        //       ),
        //     ),
        //     // Padding(
        //     //   padding: const EdgeInsets.only(top: 4, right: 22.0),
        //     //   child: Row(
        //     //     children: [
        //     //       Padding(
        //     //         padding: const EdgeInsets.only(right: 1.0),
        //     //         child: Image.network(
        //     //           //'https://www.searchpng.com/wp-content/uploads/2019/02/Comment-Icon-PNG.png',
        //     //           'https://www.pngitem.com/middle/bmTibR_comment-logo-png-comment-icon-transparent-png',
        //     //           height: 40,
        //     //         ),
        //     //       ),
        //     //       Text(
        //     //         '45',
        //     //         style: GoogleFonts.averageSans(
        //     //             color: Colors.grey[700],
        //     //             fontSize: 22,
        //     //             letterSpacing: 1,
        //     //             fontWeight: FontWeight.normal),
        //     //       ),
        //     //     ],
        //     //   ),
        //     // ),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 2, left: 28.0),
        //       child: Row(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.only(right: 15.0),
        //             child: Image.asset(
        //               'assets/images/comment_icon.png',
        //               height: 35,
        //             ),
        //           ),
        //           Text(
        //             '45',
        //             style: GoogleFonts.averageSans(
        //                 color: Colors.grey[700],
        //                 fontSize: 22,
        //                 letterSpacing: 1,
        //                 fontWeight: FontWeight.normal),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),

      ],
    );
  }
}
