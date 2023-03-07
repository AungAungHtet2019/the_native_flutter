import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ReplyFilesWidget extends StatefulWidget {

  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  const ReplyFilesWidget({
    Key? key,
    required this.files,
    required this.onOpenedFile,
  }) : super(key: key);

  @override
  State<ReplyFilesWidget> createState() => _ReplyFilesWidgetState();
}

class _ReplyFilesWidgetState extends State<ReplyFilesWidget> {
  @override
  Widget build(BuildContext context) {
    final file = widget.files[0];
    return Center(
      // child: GridView.builder(
      //     shrinkWrap: true,
      //     physics: ScrollPhysics(),
      //     padding: EdgeInsets.all(16),
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 1,
      //         mainAxisSpacing: 8,
      //         crossAxisSpacing: 8
      //     ),
      //     itemCount: widget.files.length,
      //     itemBuilder: (context,index) {
      //       final file = widget.files[index];
      //       return buildFile(file);
      //     }
      // ),

     child:buildFile(file)
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size /1024;
    final mb = kb / 1024;
    final fileSize =
    mb >= 1 ? '${mb.toStringAsFixed((2))} MB' : '${kb.toString()}';
    final extension = file.extension ?? 'none';
    // final color = getColor(extension);

    return InkWell(
      onTap: (){
        widget.onOpenedFile(file);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: extension == 'png' ||  extension == 'jpg' ||  extension == 'jpeg' ? Image.file(
                  new File(file.path.toString()),
                  fit: BoxFit.fill,
                ) :
                extension == 'pdf' ?  Image.asset('assets/icons/pdf_icon.png'): Container(
                  alignment:  Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Text(
                    '.$extension',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                )
            ),
            const SizedBox(height: 8,),
            // Text(
            //   file.name,
            //   // style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            //   overflow: TextOverflow.ellipsis,
            // ),
            // Text(
            //   fileSize,
            //   // style: TextStyle(fontSize: 16),
            // )
          ],
        ),
      ),
    );
  }
}
