
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'files_page.dart';

class FilePickPage extends StatefulWidget {
  const FilePickPage({Key? key}) : super(key: key);

  @override
  State<FilePickPage> createState() => _FilePickPageState();
}

class _FilePickPageState extends State<FilePickPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: BoxConstraints(maxHeight:  400),
        padding: EdgeInsets.all(32),
        alignment: Alignment.center,
        child: ElevatedButton(
          child: Text('Pick File'),
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(
              allowMultiple: true,
              type: FileType.custom,
              allowedExtensions: ['png','jpg','pdf','mp4'],
            );
            if(result == null) return;

            ///open single file
            // final file = result.files.first;
            // openFile(file);
            //
            // print('Name: ${file.name}');
            // print('Bytes: ${file.bytes}');
            // print('Size: ${file.size}');
            // print('Extension: ${file.extension}');
            // print('Path: ${file.path}');
            //
            // final newFile = await saveFilePermanently(file);
            //
            // print('From Path: ${file.path}');
            // print('To Path: ${newFile.path}');

            openFiles(result.files);
          },
        ),
      ),
    );
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path!).copy(newFile.path);
  }

  void openFile(PlatformFile file){
    OpenFile.open(file.path);

  }

  void openFiles(List<PlatformFile> files) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FilesPage(
  files: files,
  onOpenedFile: openFile,
  )));
  }
}
