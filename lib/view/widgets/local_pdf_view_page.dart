
/*
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class LocalPdfViewPage extends StatefulWidget {

  String pdfName,url;

  LocalPdfViewPage({required this.pdfName,required this.url});

  @override
  State<LocalPdfViewPage> createState() => _LocalPdfViewPageState();
}

class _LocalPdfViewPageState extends State<LocalPdfViewPage> {

  static final int _initialPage = 1;
  int _actualPageNumber = _initialPage, _allPagesCount = 0;
  bool isSampleDoc = true;
  late PdfController _pdfController;


  @override
  void initState() {
    // TODO: implement initState

    _pdfController =  PdfController(
      document: PdfDocument.openAsset('assets/'+widget.url),
      initialPage: _initialPage,
    );

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _pdfController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdfName,style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.lightGreenAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_before,color: Colors.black),
            onPressed: () {
              _pdfController.previousPage(
                curve: Curves.ease,
                duration: Duration(milliseconds: 100),
              );
            },
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              '$_actualPageNumber/$_allPagesCount',
              style: TextStyle(fontSize: 22,color: Colors.black),
            ),
          ),
          IconButton(
            icon: Icon(Icons.navigate_next,color: Colors.black),
            onPressed: () {
              _pdfController.nextPage(
                curve: Curves.ease,
                duration: Duration(milliseconds: 100),
              );
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.refresh),
          //   onPressed: () {
          //     if (isSampleDoc) {
          //       _pdfController.loadDocument(
          //           PdfDocument.openAsset('assets/dummy.pdf'));
          //     } else {
          //       _pdfController.loadDocument(
          //           PdfDocument.openAsset('assets/sample.pdf'));
          //     }
          //     isSampleDoc = !isSampleDoc;
          //   },
          // )
        ],
      ),
      body: PdfView(
        documentLoader: Center(child: CircularProgressIndicator()),
        pageLoader: Center(child: CircularProgressIndicator()),
        controller: _pdfController,
        onDocumentLoaded: (document) {
          setState(() {
            _allPagesCount = document.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            _actualPageNumber = page;
          });
        },
      ),
    );
  }
}

 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_native_flutter/view/widgets/pdf_view_widget.dart';

import '../../utils/dialogue.dart';

class LocalPdfViewPage extends StatefulWidget {
  String pdfName,url;

  LocalPdfViewPage({required this.pdfName,required this.url});

  @override
  State<LocalPdfViewPage> createState() => _LocalPdfViewPageState();
}

class _LocalPdfViewPageState extends State<LocalPdfViewPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String remotePDFpath = "";

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(child: Text(widget.pdfName,style: TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)),
      onTap: ()async{

        // show loading indicator
        Dialogs.showLoadingDialog(context, _keyLoader);

        await fromAsset(widget.url,widget.pdfName).then((f) {
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
              builder: (context) => PDFScreen(name: widget.pdfName,path: remotePDFpath),
            ),
          );
        }

      },
    );
  }
}


