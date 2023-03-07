import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  openImages() async {
    try {
      // var pickedfiles = await imgpicker.pickMultiImage();
      var pickedfiles = await FilePicker.platform.pickFiles(allowMultiple: true );
      //you can use ImageCourse.camera for Camera capture
      if(pickedfiles != null){
        // imagefiles = pickedfiles;
        setState(() {
        });
      }else{
        print("No image is selected.");
      }
    }catch (e) {
      print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Multiple Image Picker Flutter"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [

              //open button ----------------
              ElevatedButton(
                  onPressed: (){
                    openImages();
                  },
                  child: Text("Open Images")
              ),

              Divider(),
              Text("Picked Files:"),
              Divider(),

              imagefiles != null?Wrap(
                children: imagefiles!.map((imageone){
                  return Container(
                      child:Card(
                        child: Container(
                          height: 100, width:100,
                          child: Image.file(File(imageone.path)),
                        ),
                      )
                  );
                }).toList(),
              ):Container()
            ],
          ),
        )
    );
  }
}