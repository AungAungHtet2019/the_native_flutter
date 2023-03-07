// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
//
// class ChatPage extends StatefulWidget {
//   // ChatPage({Key? key, required this.arguments}) : super(key: key);
//   //
//   // final ChatPageArguments arguments;
//
//   @override
//   ChatPageState createState() => ChatPageState();
// }
//
// class ChatPageState extends State<ChatPage> {
//   late String currentUserId;
//
//   int _limit = 20;
//   int _limitIncrement = 20;
//   String groupChatId = "";
//
//   File? imageFile;
//   bool isLoading = false;
//   bool isShowSticker = false;
//   String imageUrl = "";
//
//   final TextEditingController textEditingController = TextEditingController();
//   final ScrollController listScrollController = ScrollController();
//   final FocusNode focusNode = FocusNode();
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     focusNode.addListener(onFocusChange);
//     listScrollController.addListener(_scrollListener);
//     readLocal();
//   }
//
//   _scrollListener() {
//
//   }
//
//   void onFocusChange() {
//     if (focusNode.hasFocus) {
//       // Hide sticker when keyboard appear
//       setState(() {
//         isShowSticker = false;
//       });
//     }
//   }
//
//   void readLocal() {
//
//   }
//
//   Future getImage() async {
//     ImagePicker imagePicker = ImagePicker();
//     PickedFile? pickedFile;
//
//     pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       imageFile = File(pickedFile.path);
//       if (imageFile != null) {
//         setState(() {
//           isLoading = true;
//         });
//         uploadFile();
//       }
//     }
//   }
//
//   void getSticker() {
//     // Hide keyboard when sticker appear
//     focusNode.unfocus();
//     setState(() {
//       isShowSticker = !isShowSticker;
//     });
//   }
//
//   Future uploadFile() async {
//
//   }
//
//   void onSendMessage(String content, int type) {
//
//   }
//
//   // Widget buildItem(int index) {
//   //
//   // }
//
//    isLastMessageLeft(int index) {
//
//   }
//
//   isLastMessageRight(int index) {
//
//   }
//
//   nBackPress() {
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         backgroundColor: Colors.lightGreen,
//         elevation: 0.0,
//         centerTitle: true,
//         title: new Text('Chat Area',
//             style: new TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.white)),
//       ),
//       body: SafeArea(
//         child: WillPopScope(
//           child: Stack(
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   // List of messages
//                   buildListMessage(),
//
//                   // Sticker
//                   isShowSticker ? buildSticker() : SizedBox.shrink(),
//
//                   // Input content
//                   buildInput(),
//                 ],
//               ),
//
//               // Loading
//               buildLoading()
//             ],
//           ),
//           onWillPop: onBackPress,
//         ),
//       ),
//     );
//   }
//
//   // Hide sticker or back
//   Future<bool> onBackPress() {
//     if (isShowSticker) {
//       setState(() {
//         isShowSticker = false;
//       });
//     } else {
//       Navigator.pop(context);
//     }
//     return Future.value(false);
//   }
//
//
//   Widget buildSticker() {
//     return Expanded(
//       child: Container(
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 TextButton(
//                   onPressed: () {},
//                   child: Image.asset(
//                     'images/mimi1.gif',
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Image.asset(
//                     'images/mimi2.gif',
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Image.asset(
//                     'images/mimi3.gif',
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                 )
//               ],
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             ),
//             Row(
//               children: <Widget>[
//                 TextButton(
//                   onPressed: () {},
//                   child: Image.asset(
//                     'images/mimi4.gif',
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Image.asset(
//                     'images/mimi5.gif',
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Image.asset(
//                     'images/mimi6.gif',
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                 )
//               ],
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             ),
//             Row(
//               children: <Widget>[
//                 TextButton(
//                   onPressed: () {},
//                   child: Image.asset(
//                     'images/mimi7.gif',
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Image.asset(
//                     'images/mimi8.gif',
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Image.asset(
//                     'images/mimi9.gif',
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                 )
//               ],
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             )
//           ],
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         ),
//         decoration: BoxDecoration(
//             border: Border(top: BorderSide(color: Colors.grey, width: 0.5)), color: Colors.white),
//         padding: EdgeInsets.all(5),
//         height: 180,
//       ),
//     );
//   }
//
//   Widget buildLoading() {
//     return Positioned(
//       child: SizedBox.shrink(),
//     );
//   }
//
//   Widget buildInput() {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           // Button send image
//           Material(
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 1),
//               child: IconButton(
//                 icon: Icon(Icons.image),
//                 onPressed: getImage,
//
//               ),
//             ),
//             color: Colors.white,
//           ),
//           Material(
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 1),
//               child: IconButton(
//                 icon: Icon(Icons.face),
//                 onPressed: getSticker,
//
//               ),
//             ),
//             color: Colors.white,
//           ),
//
//           // Edit text
//           Flexible(
//             child: Container(
//               child: TextField(
//                 onSubmitted: (value) {
//
//                 },
//                 style: TextStyle( fontSize: 15),
//                 controller: textEditingController,
//                 decoration: InputDecoration.collapsed(
//                   hintText: 'Type your message...',
//                 ),
//                 // focusNode: focusNode,
//                 // autofocus: true,
//               ),
//             ),
//           ),
//
//           // Button send message
//           Material(
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 8),
//               child: IconButton(
//                 icon: Icon(Icons.send),
//                onPressed: (){},
//
//
//               ),
//             ),
//             color: Colors.white,
//           ),
//         ],
//       ),
//       width: double.infinity,
//       height: 50,
//       decoration: BoxDecoration(
//           border: Border(top: BorderSide( width: 0.5)), color: Colors.white),
//     );
//   }
//
//   Widget buildListMessage() {
//     return Flexible(
//       child:Center(
//         child: CircularProgressIndicator(
//         ),
//       ),
//     );
//   }
// }
//
// class TypeMessage {
// }
//
// class ChatPageArguments {
//   final String peerId;
//   final String peerAvatar;
//   final String peerNickname;
//
//   ChatPageArguments({required this.peerId, required this.peerAvatar, required this.peerNickname});
// }