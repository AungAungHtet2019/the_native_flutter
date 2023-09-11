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
