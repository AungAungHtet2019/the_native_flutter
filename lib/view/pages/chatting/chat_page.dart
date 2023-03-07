// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:web_socket_channel/io.dart';
//
// class ChatPage extends StatefulWidget{
//   String uID;
//   String gID;
//
//   ChatPage(this.uID,this.gID);
//
//   @override
//   State<StatefulWidget> createState() {
//     return ChatPageState();
//   }
// }
//
// class ChatPageState extends State<ChatPage>{
//
//   late IOWebSocketChannel channel; //channel varaible for websocket
//   late bool connected; // boolean value to track connection status
//
//   // String myid = "222"; //my id
//   // String recieverid = "111"; //reciever id
//   // swap myid and recieverid value on another mobile to test send and recieve
//   String auth = "chatapphdfgjd34534hjdfk"; //auth key
//
//   List<MessageData> msglist = [];
//
//   TextEditingController msgtext = TextEditingController();
//
//   @override
//   void initState() {
//     connected = false;
//     msgtext.text = "";
//     channelconnect();
//     super.initState();
//   }
//
//   channelconnect(){ //function to connect
//     try{
//       channel = IOWebSocketChannel.connect("ws://192.168.4.91:6060/"+widget.uID); //channel IP : Port
//       channel.stream.listen((message) {
//         print("Hello "+message);
//         setState(() {
//           if(message == "connected"){
//             connected = true;
//             setState(() { });
//             print("Connection establised.");
//           }else if(message == "send:success"){
//             print("Message send success");
//             setState(() {
//               msgtext.text = "";
//             });
//           }else if(message == "send:error"){
//             print("Message send error");
//           }else if (message.substring(0, 6) == "{'cmd'") {
//             print("Message data");
//             message = message.replaceAll(RegExp("'"), '"');
//             var jsondata = json.decode(message);
//
//             msglist.add(MessageData( //on message recieve, add data to model
//               msgtext: jsondata["msgtext"],
//               userid: jsondata["userid"],
//               isme: false,
//             )
//             );
//             setState(() { //update UI after adding data to message model
//
//             });
//           }
//         });
//       },
//         onDone: () {
//           //if WebSocket is disconnected
//           print("Web socket is closed");
//           setState(() {
//             connected = false;
//           });
//         },
//         onError: (error) {
//           print(error.toString());
//         },);
//     }catch (_){
//       print("error on connecting to websocket.");
//     }
//   }
//
//   Future<void> sendmsg(String sendmsg, String id) async {
//     if(connected == true){
//       String msg = "{'auth':'$auth','cmd':'send','userid':'$id', 'msgtext':'$sendmsg'}";
//       setState(() {
//         msgtext.text = "";
//         msglist.add(MessageData(msgtext: sendmsg, userid: widget.uID, isme: true));
//       });
//       channel.sink.add(msg); //send message to reciever channel
//     }else{
//       channelconnect();
//       print("Websocket is not connected.");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("My ID: "+widget.uID+" - Chat App Example"),
//           leading: Icon(Icons.circle, color: connected?Colors.greenAccent:Colors.redAccent),
//           //if app is connected to node.js then it will be gree, else red.
//           titleSpacing: 0,
//         ),
//         body: Container(
//             child: Stack(children: [
//               Positioned(
//                   top:0,bottom:70,left:0, right:0,
//                   child:Container(
//                       padding: EdgeInsets.all(15),
//                       child: SingleChildScrollView(
//                           child:Column(children: [
//
//                             Container(
//                               child:Text("Your Messages", style: TextStyle(fontSize: 20)),
//                             ),
//
//                             Container(
//                                 child: Column(
//                                   children: msglist.map((onemsg){
//                                     return Container(
//                                         margin: EdgeInsets.only( //if is my message, then it has margin 40 at left
//                                           left: onemsg.isme?40:0,
//                                           right: onemsg.isme?0:40, //else margin at right
//                                         ),
//                                         child: Card(
//                                             color: onemsg.isme?Colors.blue[100]:Colors.red[100],
//                                             //if its my message then, blue background else red background
//                                             child: Container(
//                                               width: double.infinity,
//                                               padding: EdgeInsets.all(15),
//
//                                               child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//
//                                                   Container(
//                                                       child:Text(onemsg.isme?"ID: ME":"ID: " + onemsg.userid)
//                                                   ),
//
//                                                   Container(
//                                                     margin: EdgeInsets.only(top:10,bottom:10),
//                                                     child: Text("Message: " + onemsg.msgtext, style: TextStyle(fontSize: 17)),
//                                                   ),
//
//                                                 ],),
//                                             )
//                                         )
//                                     );
//                                   }).toList(),
//                                 )
//                             )
//                           ],)
//                       )
//                   )
//               ),
//
//               Positioned(  //position text field at bottom of screen
//
//                 bottom: 0, left:0, right:0,
//                 child: Container(
//                     color: Colors.black12,
//                     height: 70,
//                     child: Row(children: [
//
//                       Expanded(
//                           child: Container(
//                             margin: EdgeInsets.all(10),
//                             child: TextField(
//                               controller: msgtext,
//                               decoration: InputDecoration(
//                                   hintText: "Enter your Message"
//                               ),
//                             ),
//                           )
//                       ),
//
//                       Container(
//                           margin: EdgeInsets.all(10),
//                           child: ElevatedButton(
//                             child:Icon(Icons.send),
//                             onPressed: (){
//                               if(msgtext.text != ""){
//                                 sendmsg(msgtext.text, widget.gID); //send message with webspcket
//                               }else{
//                                 print("Enter message");
//                               }
//                             },
//                           )
//                       )
//                     ],)
//                 ),
//               )
//             ],)
//         )
//     );
//   }
// }
//
// class MessageData{ //message data model
//   String msgtext, userid;
//   bool isme;
//   MessageData({required this.msgtext, required this.userid, required this.isme});
//
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';

import '../../../model/member_model.dart';

class ChatPage extends StatefulWidget{

  String userID;
  // List<MemberModel> memberList;
  String receiverID;
  String receiverName;
  ChatPage(this.userID,
      // this.memberList,
      this.receiverID,
      this.receiverName
      );

  @override
  State<StatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage>{

  late IOWebSocketChannel channel; //channel varaible for websocket
  late bool connected; // boolean value to track connection status

  String myid = "222"; //my id
  String recieverid = "111"; //reciever id
  // swap myid and recieverid value on another mobile to test send and recieve
  String auth = "chatapphdfgjd34534hjdfk"; //auth key

  List<MessageData> msglist = [];

  TextEditingController msgtext = TextEditingController();

  @override
  void initState() {
    connected = false;
    msgtext.text = "";
    channelconnect();
    super.initState();
  }

  channelconnect(){ //function to connect
    try{
      // channel = IOWebSocketChannel.connect("ws://192.168.4.91:6060/$myid"); //channel IP : Port
      channel = IOWebSocketChannel.connect("ws://68.178.173.121:4242/"+widget.userID); //channel IP : Port

      channel.stream.listen((message) {
        print(message);
        setState(() {
          if(message == "connected"){
            connected = true;
            setState(() { });
            print("Connection establised.");
          }else if(message == "send:success"){
            print("Message send success");
            setState(() {
              msgtext.text = "";
            });
          }else if(message == "send:error"){
            print("Message send error");
          }else if (message.substring(0, 6) == "{'cmd'") {
            print("Message data");
            message = message.replaceAll(RegExp("'"), '"');
            var jsondata = json.decode(message);

            msglist.add(MessageData( //on message recieve, add data to model
              msgtext: jsondata["msgtext"],
              userid: jsondata["userid"],
              isme: false,
            )
            );
            setState(() { //update UI after adding data to message model

            });
          }
        });
      },
        onDone: () {
          //if WebSocket is disconnected
          print("Web socket is closed");
          setState(() {
            connected = false;
          });
        },
        onError: (error) {
          print(error.toString());
        },);
    }catch (_){
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendmsg(String sendmsg, String id) async {
    if(connected == true){
      String msg = "{'auth':'$auth','cmd':'send','userid':'$id', 'msgtext':'$sendmsg'}";
      setState(() {
        msgtext.text = "";
        // msglist.add(MessageData(msgtext: sendmsg, userid: myid, isme: true));
        msglist.add(MessageData(msgtext: sendmsg, userid: widget.userID, isme: true));

      });
      channel.sink.add(msg); //send message to reciever channel
    }else{
      channelconnect();
      print("Websocket is not connected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text("My ID: "+widget.userID+" - Chat App Example"),
          title: Text(widget.receiverName),
          centerTitle: true,

          leading: Icon(Icons.circle, color: connected?Colors.greenAccent:Colors.redAccent),
          //if app is connected to node.js then it will be gree, else red.
          titleSpacing: 0,
        ),
        body: SafeArea(
            child: Stack(children: [
              Positioned(
                  top:0,bottom:70,left:0, right:0,
                  child:Container(
                      padding: EdgeInsets.all(15),
                      child: SingleChildScrollView(
                          child:Column(children: [

                            Container(
                              child:Text("Your Messages", style: TextStyle(fontSize: 20)),
                            ),

                            Container(
                                child: Column(
                                  children: msglist.map((onemsg){
                                    // return Container(
                                    //     margin: EdgeInsets.only( //if is my message, then it has margin 40 at left
                                    //       left: onemsg.isme?40:0,
                                    //       right: onemsg.isme?0:40, //else margin at right
                                    //     ),
                                    //     child: Card(
                                    //         color: onemsg.isme?Colors.blue[100]:Colors.red[100],
                                    //         //if its my message then, blue background else red background
                                    //         child: Container(
                                    //           width: double.infinity,
                                    //           padding: EdgeInsets.all(15),
                                    //
                                    //           child: Column(
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //
                                    //               Container(
                                    //                   child:Text(onemsg.isme?"ID: ME":"ID: " + onemsg.userid)
                                    //               ),
                                    //
                                    //               Container(
                                    //                 margin: EdgeInsets.only(top:10,bottom:10),
                                    //                 child: Text("Message: " + onemsg.msgtext, style: TextStyle(fontSize: 17)),
                                    //               ),
                                    //
                                    //             ],),
                                    //         )
                                    //     )
                                    // );
                                    return Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            onemsg.isme ? MainAxisAlignment.end : MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              if (!onemsg.isme)
                                                CircleAvatar(
                                                  radius: 15,
                                                  // backgroundImage: AssetImage(user.avatar),
                                                ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                constraints: BoxConstraints(
                                                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                                                decoration: BoxDecoration(
                                                    color: onemsg.isme ? Colors.blue : Colors.grey[200],
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(16),
                                                      topRight: Radius.circular(16),
                                                      bottomLeft: Radius.circular(onemsg.isme ? 12 : 0),
                                                      bottomRight: Radius.circular(onemsg.isme ? 0 : 12),
                                                    )),
                                                child: Text(
                                                  onemsg.msgtext,
                                                  style: TextStyle(
                                                      color: onemsg.isme ? Colors.white : Colors.grey[800]),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                              onemsg.isme ? MainAxisAlignment.end : MainAxisAlignment.start,
                                              children: [
                                                if (!onemsg.isme)
                                                  SizedBox(
                                                    width: 40,
                                                  ),
                                                Icon(
                                                  Icons.done_all,
                                                  size: 20,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  // "1.1.2023",
                                                  DateTime.now().toString().split('.')[0],
                                                  style: TextStyle(color: Colors.grey),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                )
                            )
                          ],)
                      )
                  )
              ),

              Positioned(  //position text field at bottom of screen

                bottom: 0, left:0, right:0,
                // child: Container(
                //     color: Colors.black12,
                //     height: 70,
                //     child: Row(children: [
                //
                //       Expanded(
                //           child: Container(
                //             margin: EdgeInsets.all(10),
                //             child: TextField(
                //               controller: msgtext,
                //               decoration: InputDecoration(
                //                   hintText: "Enter your Message"
                //               ),
                //             ),
                //           )
                //       ),
                //
                //       Container(
                //           margin: EdgeInsets.all(10),
                //           child: ElevatedButton(
                //             child:Icon(Icons.send),
                //             onPressed: (){
                //               if(msgtext.text != ""){
                //                 sendmsg(msgtext.text, recieverid); //send message with webspcket
                //               }else{
                //                 print("Enter message");
                //               }
                //             },
                //           )
                //       )
                //     ],)
                // ),
                child:buildInput()
              )
            ],)
        )
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: (){

                }

              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Icon(Icons.face),
                onPressed: (){

                },

              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {

                },
                style: TextStyle( fontSize: 15),
                controller: msgtext,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                ),
                // focusNode: focusNode,
                // autofocus: true,
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

                  if(msgtext.text != "")
                  {
                    // sendmsg(msgtext.text, recieverid); //send message with webspcket
                    // widget.memberList.map((e) => sendmsg(msgtext.text, e.PersonID)); //send message with webspcket)
                    sendmsg(msgtext.text, widget.receiverID); //send message with webspcket

                  }else{
                    print("Enter message");
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
    );
  }
}

class MessageData{ //message data model
  String msgtext, userid;
  bool isme;
  MessageData({required this.msgtext, required this.userid, required this.isme});

}