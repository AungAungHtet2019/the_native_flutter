
import 'package:flutter/material.dart';
import 'package:the_native_flutter/view/widgets/local_pdf_view_page.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  Future<void> dialCall() async {
    String phoneNumber = "+9592004077";
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28.0,right:28.0,top: 8.0,bottom: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                gradient: LinearGradient(
                  colors: [
                    // Colors.yellow,
                    // Colors.orangeAccent,
                    // Colors.yellow.shade300,
                    Colors.green,
                    Colors.lightGreenAccent,
                    Colors.lightGreen,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Center(child: Text("Mission",style: TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LocalPdfViewPage(pdfName: 'Mission',url: 'pdf/Mission.pdf',)));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0,right: 28.0,bottom: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.green,
                    Colors.lightGreenAccent,
                    Colors.lightGreen,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Center(child: Text("Vision",style: TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LocalPdfViewPage(pdfName: 'Vision',url: 'pdf/Vision.pdf',)));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0,right: 28.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                gradient: LinearGradient(
                  colors: [
                    // Colors.orangeAccent,
                    // Colors.red,
                    // Colors.orange,
                    Colors.green,
                    Colors.lightGreenAccent,
                    Colors.lightGreen,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Center(child: Text("Pilot Project",style: TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LocalPdfViewPage(pdfName: 'Pilot Project',url: 'pdf/Pilot_Project.pdf',)));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0,right:28.0,top: 8.0,bottom: 8.0),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("Contact Phone",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  ListTile(
                    // leading: Container(
                    //   width: 20,
                    //   height: 20,
                    //   child: Image.asset('assets/icons/whatsapp.png'),
                    // ),
                    leading: Icon(Icons.phone,color: Colors.green,),
                    title: Text("+9592004077"),
                    onTap: (){
                      dialCall();
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0,right:28.0,top: 8.0,bottom: 8.0),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("Email",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  ListTile(
                    leading: Icon(Icons.email,color: Colors.green,),
                    title: Text("contact@zartimyay.org"),
                    onTap: (){
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0,right:28.0,top: 8.0,bottom: 8.0),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("Website",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  ListTile(
                    leading: Icon(Icons.wb_cloudy,color: Colors.green,),
                    title: Text("https://zartimyay.org"),
                    onTap: (){
                    },
                  ),
                ],
              ),
            ),
          )


        ],
      )
    );
  }
}
