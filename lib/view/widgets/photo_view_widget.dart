import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../model/case_file_model.dart';

class PhotoViewWidget extends StatefulWidget {

  List<CaseFile> photoList;
  PhotoViewWidget(this.photoList);

  @override
  State<PhotoViewWidget> createState() => _PhotoViewWidgetState();
}

class _PhotoViewWidgetState extends State<PhotoViewWidget> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        centerTitle: true,
        leading: Container(),
        backgroundColor: Colors.black,
      ),
      body: Container(
          child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.photoList[index].DomainName+widget.photoList[index].CaseFilePath),
                // initialScale: PhotoViewComputedScale.contained * 0.8,
                // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
              );
            },
            itemCount: widget.photoList.length,
            loadingBuilder: (context, event) => Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  // value: event == null
                  //     ? 0
                  //     : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                ),
              ),
            ),
            // backgroundDecoration: widget.backgroundDecoration,
            // pageController: widget.pageController,
            // onPageChanged: onPageChanged,
          )
      ),
    );
  }
}
