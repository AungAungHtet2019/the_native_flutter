import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class NewsDetailPage extends StatefulWidget {

  String title;
  String contentText;

   NewsDetailPage({Key? key,required this.title,required this.contentText}) : super(key: key);

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
      ),
        body: Center(
          child: SingleChildScrollView(
            child: Html(
              data: """
                """+widget.contentText+"""
                """,
              /*
              padding: EdgeInsets.all(8.0),
              onLinkTap: (url) {
                print("Opening $url...");
              },

               */
              // customRender: (node, children) {
              //   // if (node is dom.Element) {
              //   //   switch (node.localName) {
              //   //     case "custom_tag": // using this, you can handle custom tags in your HTML
              //   //       return Column(children: children);
              //   //     default:
              //   //       return Column(children: [],);
              //   //   }
              //   // }
              //   // else{
              //   //   return Column(children: [],);
              //   // }
              //   if(node is dom.Element) {
              //     switch(node.localName) {
              //       case "img": return Container(child: Image.network(node.attributes!["src"] ?? "",fit: BoxFit.fill,)
              //           ,padding: MediaQuery.of(context).orientation == Orientation.portrait ? EdgeInsets.only(left: 0.0,right: 0.0):EdgeInsets.only(left: 50.0,right: 50.0),
              //           width: double.infinity,
              //           //height: 200.0,
              //           height: MediaQuery.of(context).orientation == Orientation.portrait ? 200.0:400.0 );
              //       case "p":return Text(node.text,);
              //         default:
              //           return Container();
              //
              //     }
              //   }
              //   else{
              //     return Container();
              //   }
              //
              // },
            ),
          ),
        )
    );
  }
}
