import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_native_flutter/provider/crop_monitioring_provider.dart';
import 'package:the_native_flutter/provider/user_provider.dart';
import 'package:the_native_flutter/utils/global.dart';

import '../../../model/eos_image_history_model.dart';
import '../../widgets/geo_server_widget.dart';

class EosAnalysisImageHistoryPage extends StatefulWidget {
  EosAnalysisImageHistoryPage({Key? key}) : super(key: key);

  @override
  State<EosAnalysisImageHistoryPage> createState() => _EosAnalysisImageHistoryPageState();
}

class _EosAnalysisImageHistoryPageState extends State<EosAnalysisImageHistoryPage> {

  bool selectDataStatus = false;

  getEosImageHistory()async{
    String userId  = Provider.of<UserProvider>(context,listen: false).userModel.UserID;
    bool status = await Provider.of<CropMonitoringProvider>(context,listen: false).getEosAnalysedImageHistory(userId);
    setState(() {
      selectDataStatus = status;

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getEosImageHistory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("စိုက်ခင်းဧရိယာမှတ်တမ်း",),
        backgroundColor: Colors.lightGreen,
      ),
      body: Provider.of<CropMonitoringProvider>(context,listen: true).eosImageHistoryList.length == 0 ? Center(
        child: Text("No record"),
      )
          :ListView(
        children:Provider.of<CropMonitoringProvider>(context,listen: true).eosImageHistoryList.map((e) {
          final index = Provider.of<CropMonitoringProvider>(context,listen: true).eosImageHistoryList.indexOf(e);
          return Card(
            color: Colors.grey,
            child: ListTile(
              leading: Text((index+1).toString(),style: TextStyle(color: Colors.white),),
              title: Text(e.createAt.replaceAll("T"," ").split(".").first+" ရက်နေ့စိုက်ခင်းအခြေအနေ",style: TextStyle(color: Colors.white),),
              subtitle: Text(e.taskId,style: TextStyle(color: Colors.white),),
              trailing: Container(
                child: CachedNetworkImage(
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  imageUrl: domain+"/mobile/eos/"+e.imgUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),

              onTap: (){
                print("e.taskId");
                print(e.taskId);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> GeoServerWidget(
                    title: "စိုက်ခင်းအခြေအနေ",
                    latLong: "19.803387373037715, 96.26350603358078",
                    location: " ရေဆင်းအနီး ",
                    // url: "https://aungaunghtet2019.github.io/eos_crop_monitoring/"
                    url:"https://rrms.zartimyay.org/map?task="+e.taskId,
                  taskId: e.taskId,
                )));

              },

            ),
          );
        }).toList(),
      ),
    );
  }
}
