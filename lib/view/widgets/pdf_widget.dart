
import 'package:flutter/material.dart';
import 'package:the_native_flutter/view/widgets/pdf_view_widget.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/dialogue.dart';

class PdfWidget extends StatefulWidget {
  String fileUrl;
  PdfWidget({Key? key,required this.fileUrl}) : super(key: key);

  @override
  State<PdfWidget> createState() => _PdfWidgetState();
}

class _PdfWidgetState extends State<PdfWidget> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String remotePDFpath = "";

  Future<File> createFileOfPdfUrl(String fileUrl) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      // final url = "http://www.pdf995.com/samples/pdf.pdf";
      final url = fileUrl;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Image.asset("assets/icons/pdf_icon.png"),
      onTap: ()async{

        // show loading indicator
        Dialogs.showLoadingDialog(context, _keyLoader);

        await createFileOfPdfUrl(widget.fileUrl).then((f) {
          setState(() {
            remotePDFpath = f.path;
          });
        });

        // hide loading indicator
        Navigator.pop(context);

        if (remotePDFpath.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFScreen(name: "Document",path: remotePDFpath),
            ),
          );
        }

        // Navigator.push(context, MaterialPageRoute(builder: (context)=> PdfViewWidget()));
      },
    );
  }
}
