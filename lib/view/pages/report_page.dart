import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../../utils/dialogue.dart';
import '../../utils/rest_api.dart';
import '../widgets/files_widget.dart';

class ReportPage extends StatefulWidget {

  String userID;
  String gurdiamGroupID;

  ReportPage(this.userID,this.gurdiamGroupID);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController _contentTxtController = TextEditingController();
  TextEditingController _summeryTxtController = TextEditingController();
  FilePickerResult? result;
  var currentSelectedValue;
  var resultFiels;

  List<PlatformFile> images = [];
  List<PlatformFile> files = [];
  List resultList = [];


  bool _isChecked = true;

  List<String> _texts = [
    "တိုင်းဒေသကြီး",
    "ခရိုင်",
    "မြို့နယ်"
  ];

  final Map<String, bool> _map = {
    // "တိုင်းဒေသကြီး":false,
    // "ခရိုင်":false,
    "မြို့နယ်":false,
  };
  int _count = 0;


  getData() async {
    await Provider.of<UserProvider>(context,listen: false).getCategory();
  }

  sendReportFormData(String pID,String gID,String category_id,String caseSubject,String caseBody,bool div_see_status,bool dis_see_status,bool townsh_see_status)async{

    Map body = {
      "personID":"$pID",
      "groupID":"$gID",
      "categoryID":"$category_id",
      "caseSubject":"$caseSubject",
      "caseBody":"$caseBody",
      "division_see_status":div_see_status,
      "district_see_status":dis_see_status,
      "township_see_status":townsh_see_status
    };

    var jsonbody = json.encode(body);

    await ApiService.reportForm(jsonbody).then((value) {
      print(value);
      if(value !="NoOK")
        {
          _submit(value);

        }
      else{
        statusDialog("Pleas try again.");
      }


    });


  }

  _submit(String cID) async {

    String folderName = DateTime.now().microsecondsSinceEpoch.toString()+"/";
    for (int i = 0; i < images.length; i++) {
      // var path2 = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      var path2 = await images[i].path;
      print(path2);
      print("MyPath");
      // final file = images[i];
      // PlatformFile file = images[i];
      final bytes = await File(path2!).readAsBytesSync();
      // print(bytes);
      String img64 = base64Encode(bytes!);
      print(img64);
    //   files.add(base64Image);
    //   var data = {
    //     "files": files,
    //   };
    //   try {
    //     var response = await http.post(data, 'url')
    //     var body = jsonDecode(response.body);
    //     print(body);
    //     if (body['msg'] == "Success!") {
    //       print('posted successfully!');
    //     } else {
    //       _showToast(context, body['msg']);
    //     }
    //   } catch (e) {
    //     return e.message;
    //   }


      Map body={
        "userID":widget.userID,
        'caseID':cID,
        'case_File_Size':images[i].size.toString(),
        'folderName':folderName,
        'fileName':images[i].name,
        'base64': img64,
      };
      var jsonbody = json.encode(body);
      await ApiService.multiFileUpload(jsonbody).then((success) {
        print("++++++++++++++++++++++++"+success.toString());
        print("***********************");
      });

    }
    statusDialog("Successfully reported.");
  }

  void statusDialog(String title) {


    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("The Native "),
          content: Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: new Text(title),
          ),
          actions: <Widget>[
            // CupertinoDialogAction(
            //   isDefaultAction: true,
            //   child: Text("This phone number is already registered",style: TextStyle(color: Colors.red,fontSize: 12.0)),
            // ),
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                if(title == "Successfully reported."){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
                else{
                  Navigator.pop(context);
                }


              },
            )
          ],
        );
      },
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("စာပို့ရန်",style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: _contentTxtController,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                  hintText: "အကြောင်းအရာ",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.redAccent)
                  )
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: _summeryTxtController,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: "အကျဉ်းချုပ်",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.lightGreenAccent)
                  )
              ),

            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text("Select Category"),
                      value: currentSelectedValue,
                      isDense: true,
                      onChanged: (newValue) {
                        setState(() {
                          currentSelectedValue = newValue;
                        });
                        print(currentSelectedValue);
                      },
                      items: Provider.of<UserProvider>(context,listen: true).categoryList.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.CategoryCode,
                          child: Text(value.CategoryName),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(result != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Selected file:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: result?.files.length ?? 0,
                          itemBuilder: (context, index) {
                            return Text(result?.files[index].name ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
                          })
                    ],
                  ),),
              if(resultFiels != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    color: Colors.white54,
                    child: FilesWidget(
                      files: resultFiels.files,
                      onOpenedFile: openFile,
                    ),
                  ),
                ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.green)
                          )
                      )
                  ),
                  onPressed: () async{
                    // result = await FilePicker.platform.pickFiles(allowMultiple: true );
                    // if (result == null) {
                    //   print("No file selected");
                    // } else {
                    //   setState(() {
                    //   });
                    //   result?.files.forEach((element) {
                    //     print(element.name);
                    //   });
                    // }

                    final resultList = await FilePicker.platform.pickFiles(
                      allowMultiple: true,
                      type: FileType.custom,
                      allowedExtensions: ['png','jpg','pdf','mp4'],
                    );
                   setState(() {
                     resultFiels = resultList;
                   });

                   print(resultList);
                   images = resultFiels.files;
                   print(images.length);
                   print("ok");


                    // if(resultFiels == null) return;
                    // openFiles(resultFiels.files);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.attach_file),
                      Text("Get File")
                    ],
                  ),
                ),
              ),

            ],
          ),

          // ListView(
          //   shrinkWrap: true,
          //   physics: ScrollPhysics(),
          //   padding: EdgeInsets.all(8.0),
          //   children: _texts.map((text) => CheckboxListTile(
          //     title: Text(text),
          //     value: _isChecked,
          //     onChanged: (val) {
          //       setState(() {
          //         _isChecked = val!;
          //
          //       });
          //     },
          //   )).toList(),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: _map.keys
                  .map(
                    (key) => CheckboxListTile(
                  value: _map[key],
                  onChanged: (value) {
                    setState(() {
                      _map[key] = value!;
                    });
                  },
                  subtitle: Text(key),
                ),
              )
                  .toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.green)
                      )
                  )
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Send',
                    style: new TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                if(_map["မြို့နယ်"] != false && _contentTxtController.text != "" && _summeryTxtController.text != " "){
                  // print(_map);
                  Dialogs.showLoadingDialog(context, _keyLoader);
                  // _submit();
                  sendReportFormData(widget.userID,widget.gurdiamGroupID,currentSelectedValue,_contentTxtController.text,_summeryTxtController.text,true,true,_map["မြို့နယ်"]!);
                }
                else{
                  statusDialog("Please fill all field and check Township");
                }

              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //  onPressed: (){
      //     setState(() {
      //       _map.addEntries([MapEntry('Checkbox #${++_count}', false)]);
      //       print(_map);
      //     });
      //  },
      // ),
    );
  }

  // Future<File> saveFilePermanently(PlatformFile file) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final newFile = File('${appStorage.path}/${file.name}');
  //
  //   return File(file.path!).copy(newFile.path);
  // }

  void openFile(PlatformFile file){
    OpenFile.open(file.path);

  }

  // void openFiles(List<PlatformFile> files) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FilesWidget(
  //     files: files,
  //     onOpenedFile: openFile,
  //   ))
  //   );
  // }
}
