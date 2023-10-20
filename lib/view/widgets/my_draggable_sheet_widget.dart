import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/crop_monitioring_provider.dart';

class MyDraggableSheet extends StatefulWidget {
  String taskId;
   MyDraggableSheet({Key? key,required this.taskId}) : super(key: key);

  @override
  State<MyDraggableSheet> createState() => _MyDraggableSheetState();
}

class _MyDraggableSheetState extends State<MyDraggableSheet> {

  bool loading_status = false;
  int resultLength = 0;

  Future<void> eos()async{

    print(loading_status);
    setState(() {
      loading_status = true;
    });
    print(loading_status);

    print("Hey taskId "+widget.taskId);
    await Provider.of<CropMonitoringProvider>(context,listen: false).getMapPolygonPoints(widget.taskId);

    print(Provider.of<CropMonitoringProvider>(context,listen:  false).latLngList.length);
    List lngLatList = [];
    lngLatList.clear();
    await Provider.of<CropMonitoringProvider>(context,listen:  false).latLngList.map((e) {
      try{
        lngLatList.add([e.lng,e.lat]);
      }
      catch(exp){
        print(exp);
      }
      print(e.lat);
    }).toList();
    print("lngLatList");
    print(lngLatList);

    String startDate = DateTime.now().subtract(Duration(days:30)).toString().split(" ")[0];
    String endDate = DateTime.now().subtract(Duration(days:2)).toString().split(" ")[0];

    await Provider.of<CropMonitoringProvider>(context,listen: false).createMultiTemporalStatistics(lngLatList,startDate,endDate);
    resultLength =  await Provider.of<CropMonitoringProvider>(context,listen: false).statisticModelList.length;
    print("length is ");
    print(Provider.of<CropMonitoringProvider>(context,listen: false).statisticModelList);

    setState(() {
      loading_status = false;
    });
    if(resultLength > 0){

      //Navigator.push(context, MaterialPageRoute(builder: (context)=> EosIndexPage()));
    }
    else{

      /*
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Message'),
          content: Text(
              Provider.of<CropMonitoringProvider>(context,listen: false).multiTemporaalStatisticsError
          ),
          actions: <Widget>[
            new TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(); // dismisses only the dialog and returns nothing
              },
              child: new Text('OK'),
            ),
          ],
        ),
      );


       */

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eos();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      maxChildSize: 1,
      minChildSize: 0.2,
      expand: true,
      snap: true,
      snapSizes: const [0.5],
      builder: (BuildContext context,ScrollController scrollController){
        return Container(
          color: Colors.grey[100],

          /*
          child: ListView.separated(
              itemBuilder: (context, index) => _dailyCard(),
              separatorBuilder: (context, index) => Divider(),
              itemCount: 10
          ),

           */

          child: Provider.of<CropMonitoringProvider>(context,listen: false).statisticModelList != [] && resultLength > 0 && loading_status == false ?
          ListView(
            controller: scrollController,
              physics: BouncingScrollPhysics(),
              children: Provider.of<CropMonitoringProvider>(context,listen: false).statisticModelList.map((e) {
                return Card(
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            color: Colors.lightBlueAccent,
                            child: Center(child: Text(e.date,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))),
                      ),
                      // Text(e.sceneId),
                      // Text(e.viewId),
                      //
                      // Text(e.cloud.toString()),

                      /*
                Text("MSI"),

                Text(e.indexes!.msi!.q1.toString()),
                Text(e.indexes!.msi!.q3.toString()),
                Text(e.indexes!.msi!.max.toString()),
                Text(e.indexes!.msi!.min.toString()),
                Text(e.indexes!.msi!.p10.toString()),
                Text(e.indexes!.msi!.p90.toString()),
                Text(e.indexes!.msi!.std.toString()),
                Text(e.indexes!.msi!.median.toString()),
                Text(e.indexes!.msi!.average.toString()),
                Text(e.indexes!.msi!.variance.toString()),

                Divider(),

                 */
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("သီးနှံပင်ကျန်းမာရေး(NDVI)",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: Provider.of<CropMonitoringProvider>(context,listen: false).cropMonitoringIndexList.map((f) {
                          return Column(
                            children: [
                              /*
                        e.indexes!.ndvi!.q1 <= f.maxValue && e.indexes!.ndvi!.q1 >= f.minValue && f.type == "NDVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.ndvi!.q1.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.ndvi!.q3 <= f.maxValue && e.indexes!.ndvi!.q3 >= f.minValue && f.type == "NDVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.ndvi!.q3.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.ndvi!.max <= f.maxValue && e.indexes!.ndvi!.max >= f.minValue && f.type == "NDVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.ndvi!.max.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.ndvi!.min <= f.maxValue && e.indexes!.ndvi!.min >= f.minValue && f.type == "NDVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.ndvi!.min.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.ndvi!.p10 <= f.maxValue && e.indexes!.ndvi!.p10 >= f.minValue && f.type == "NDVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.ndvi!.p10.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.ndvi!.p90 <= f.maxValue && e.indexes!.ndvi!.p90 >= f.minValue && f.type == "NDVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.ndvi!.p90.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.ndvi!.std <= f.maxValue && e.indexes!.ndvi!.std >= f.minValue && f.type == "NDVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.ndvi!.std.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.ndvi!.median <= f.maxValue && e.indexes!.ndvi!.median >= f.minValue && f.type == "NDVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.ndvi!.median.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.ndvi!.average <= f.maxValue && e.indexes!.ndvi!.average >= f.minValue && f.type == "NDVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.ndvi!.average.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.ndvi!.variance <= f.maxValue && e.indexes!.ndvi!.variance >= f.minValue && f.type == "NDVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.ndvi!.variance.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                         */
                              e.indexes!.ndvi!.average <= f.maxValue && e.indexes!.ndvi!.average >= f.minValue && f.type == "NDVI" ? Row(
                                children: [
                                  Container(
                                    color: Color(int.parse(f.indexColor)),
                                    width: 10,
                                    height: 10,
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text(e.indexes!.ndvi!.average.toString(),textAlign: TextAlign.start,),
                                        Text(f.mmDescription,textAlign: TextAlign.start,),
                                      ],
                                    ),
                                  ),
                                ],
                              ) :SizedBox(),
                            ],
                          );
                        }).toList(),
                      ),

                      Divider(),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("သီးနှံပင်ရောဂါကျရောက်မှုအခြေအနေ(NDRE)",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: Provider.of<CropMonitoringProvider>(context,listen: false).cropMonitoringIndexList.map((f) {
                          return Column(
                            children: [
                              /*
                        e.indexes!.evi!.q1 <= f.maxValue && e.indexes!.evi!.q1 >= f.minValue && f.type == "NDRE" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.evi!.q1.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.evi!.q3 <= f.maxValue && e.indexes!.evi!.q3 >= f.minValue && f.type == "NDRE" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.evi!.q3.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.evi!.max <= f.maxValue && e.indexes!.evi!.max >= f.minValue && f.type == "NDRE" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.evi!.max.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.evi!.min <= f.maxValue && e.indexes!.evi!.min >= f.minValue && f.type == "NDRE" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.evi!.min.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.evi!.p10 <= f.maxValue && e.indexes!.evi!.p10 >= f.minValue && f.type == "NDRE" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.evi!.p10.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.evi!.p90 <= f.maxValue && e.indexes!.evi!.p90 >= f.minValue && f.type == "NDRE" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.evi!.p90.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.evi!.std <= f.maxValue && e.indexes!.evi!.std >= f.minValue && f.type == "NDRE" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.evi!.std.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.evi!.median <= f.maxValue && e.indexes!.evi!.median >= f.minValue && f.type == "NDRE" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.evi!.median.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.evi!.variance <= f.maxValue && e.indexes!.evi!.variance >= f.minValue && f.type == "NDRE" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.evi!.variance.toString(),textAlign: TextAlign.start,),
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :SizedBox(),

                         */
                              e.indexes!.ndre!.average <= f.maxValue && e.indexes!.ndre!.average >= f.minValue && f.type == "NDRE" ? Row(
                                children: [
                                  Container(
                                    color: Color(int.parse(f.indexColor)),
                                    width: 10,
                                    height: 10,
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text(e.indexes!.ndre!.average.toString(),textAlign: TextAlign.start,),
                                        Text(f.mmDescription,textAlign: TextAlign.start,),
                                      ],
                                    ),
                                  ),
                                ],
                              ) :SizedBox(),
                            ],
                          );
                        }).toList(),
                      ),

                      Divider(),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("သီးနှံကြီးထွားမှုနှင့်မြေသြဇာလိုအပ်ချက်(MSAVI)",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: Provider.of<CropMonitoringProvider>(context,listen: false).cropMonitoringIndexList.map((f) {
                          return Column(
                            children: [
                              /*
                        e.indexes!.msi!.q1 <= f.maxValue && e.indexes!.msi!.q1 >= f.minValue && f.type == "MSAVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.msi!.q1.toString(),textAlign: TextAlign.start,),
                                myTextWidget(f.mmDescription),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.msi!.q3 <= f.maxValue && e.indexes!.msi!.q3 >= f.minValue && f.type == "MSAVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.msi!.q3.toString(),textAlign: TextAlign.start,),
                                myTextWidget(f.mmDescription),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.msi!.max <= f.maxValue && e.indexes!.msi!.max >= f.minValue && f.type == "MSAVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.msi!.max.toString(),textAlign: TextAlign.start,),
                                myTextWidget(f.mmDescription),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.msi!.min <= f.maxValue && e.indexes!.msi!.min >= f.minValue && f.type == "MSAVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.msi!.min.toString(),textAlign: TextAlign.start,),
                                myTextWidget(f.mmDescription),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.msi!.p10 <= f.maxValue && e.indexes!.msi!.p10 >= f.minValue && f.type == "MSAVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.msi!.p10.toString(),textAlign: TextAlign.start,),
                                myTextWidget(f.mmDescription),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.msi!.p90 <= f.maxValue && e.indexes!.msi!.p90 >= f.minValue && f.type == "MSAVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.msi!.p90.toString(),textAlign: TextAlign.start,),
                                myTextWidget(f.mmDescription),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.msi!.std <= f.maxValue && e.indexes!.msi!.std >= f.minValue && f.type == "MSAVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.msi!.std.toString(),textAlign: TextAlign.start,),
                                myTextWidget(f.mmDescription),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.msi!.median <= f.maxValue && e.indexes!.msi!.median >= f.minValue && f.type == "MSAVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.msi!.median.toString(),textAlign: TextAlign.start,),
                                myTextWidget(f.mmDescription),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        e.indexes!.msi!.variance <= f.maxValue && e.indexes!.msi!.variance >= f.minValue && f.type == "MSAVI" ? Row(
                          children: [
                            Container(
                              color: Color(int.parse(f.indexColor)),
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(e.indexes!.msi!.variance.toString(),textAlign: TextAlign.start,),
                                myTextWidget(f.mmDescription),
                              ],
                            ),
                          ],
                        ) :SizedBox(),
                        */
                              e.indexes!.msi!.average <= f.maxValue && e.indexes!.msi!.average >= f.minValue && f.type == "MSAVI" ? Row(
                                children: [
                                  Container(
                                    color: Color(int.parse(f.indexColor)),
                                    width: 10,
                                    height: 10,
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text(e.indexes!.msi!.average.toString(),
                                          textAlign: TextAlign.start,
                                        ),
                                        //Text("test")
                                        myTextWidget(f.mmDescription),
                                      ],
                                    ),
                                  ),
                                ],
                              ) :SizedBox(),
                            ],

                          );
                        }).toList(),
                      ),

                      Divider(),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Chlorophill နှင့် နိုက်ထရိုဂျင်ရရှိမှု(RECI)",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: Provider.of<CropMonitoringProvider>(context,listen: false).cropMonitoringIndexList.map((f) {
                          return Column(
                            children: [
                              e.indexes!.evi!.average <= f.maxValue && e.indexes!.evi!.average >= f.minValue && f.type == "RECI" ? Row(
                                children: [
                                  Container(
                                    color: Color(int.parse(f.indexColor)),
                                    width: 10,
                                    height: 10,
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text(e.indexes!.evi!.average.toString(),textAlign: TextAlign.start,),
                                        myTextWidget(f.mmDescription),
                                      ],
                                    ),
                                  ),
                                ],
                              ) :SizedBox(),
                            ],

                          );
                        }).toList(),
                      ),

                      Divider(),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("မြေဆီလွှာရေလိုအပ်ချက်နှင့်နေရောင်ခြည်ရရှိမှု(NDMI)",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: Provider.of<CropMonitoringProvider>(context,listen: false).cropMonitoringIndexList.map((f) {
                          return Column(
                            children: [
                              e.indexes!.ndsi!.average <= f.maxValue && e.indexes!.ndsi!.average >= f.minValue && f.type == "NDMI" ? Row(
                                children: [
                                  Container(
                                    color: Color(int.parse(f.indexColor)),
                                    width: 10,
                                    height: 10,
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text(e.indexes!.ndsi!.average.toString(),textAlign: TextAlign.start,),

                                        myTextWidget(f.mmDescription),
                                      ],
                                    ),
                                  ),
                                ],
                              ) :SizedBox(),
                            ],
                          );
                        }).toList(),
                      ),

                      /*
                ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: Provider.of<CropMonitoringProvider>(context,listen: false).cropMonitoringIndexList.map((f) {
                    return f.type == "NDVI" ? Row(
                      children: [
                        Container(
                          color: Colors.red,
                          width: 10,
                          height: 10,
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(e.indexes!.msi!.q1.toString(),textAlign: TextAlign.start,),
                            Text(f.mmDescription,textAlign: TextAlign.start,),
                          ],
                        ),
                      ],
                    ) :Container();
                  }).toList(),
                ),

                 */

                      /*
                Divider(),
                Text("EVI"),
                Text(e.indexes!.evi!.q1.toString()),
                Text(e.indexes!.evi!.q3.toString()),
                Text(e.indexes!.evi!.max.toString()),
                Text(e.indexes!.evi!.min.toString()),
                Text(e.indexes!.evi!.p10.toString()),
                Text(e.indexes!.evi!.p90.toString()),
                Text(e.indexes!.evi!.std.toString()),
                Text(e.indexes!.evi!.median.toString()),
                Text(e.indexes!.evi!.average.toString()),
                Text(e.indexes!.evi!.variance.toString()),

                 */

                      /*
                Divider(),
                Text("MSI"),
                Text(e.indexes!.msi!.q1.toString()),
                Text(e.indexes!.msi!.q3.toString()),
                Text(e.indexes!.msi!.max.toString()),
                Text(e.indexes!.msi!.min.toString()),
                Text(e.indexes!.msi!.p10.toString()),
                Text(e.indexes!.msi!.p90.toString()),
                Text(e.indexes!.msi!.std.toString()),
                Text(e.indexes!.msi!.median.toString()),
                Text(e.indexes!.msi!.average.toString()),
                Text(e.indexes!.msi!.variance.toString()),


                 */

                    ],
                  ),
                );
              }).toList()
          ): Provider.of<CropMonitoringProvider>(context,listen: false).statisticModelList.length == 0 && resultLength == 0 && loading_status == false ? Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "စိုက်ခင်းဧရိယာ၏ AI Result generate လုပ်ဆောင်ချက်မအောင်မြင်ပါသဖြင့်စိုက်ခင်းဧရိယာမှတ်တမ်းမှတစ်ဆင့်ဝင်ရောက်၍နောက်တစ်ကြိမ်ပြန်လည်ကြိုးစားပါ"
              ),
            ),
          )
              :ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardLoading(
                    height: 30,
                    width: size.width * .2,
                    padding: const EdgeInsets.only(bottom: 10),
                    borderRadius: 15,
                  ),
                  CardLoading(
                    height: size.height * .15,
                    padding: const EdgeInsets.only(bottom: 10),
                    borderRadius: 15,
                  ),
                  CardLoading(
                    height: size.height * .1,
                    padding: const EdgeInsets.only(bottom: 20),
                    borderRadius: 15,
                  ),
                ],
              );
            },
          ),

        );
      },
    );
  }

  Widget _dailyCard(){
    return Column(
      children: [
        _testCard(),
        _testCard(),
        _testCard(),
        _testCard(),
        _testCard(),
      ],
    );
  }
  Widget _testCard(){
    return Column(
      children: [
        Text("title"),
        Row(
          children: [
            Container(color: Colors.green, width: 50, height: 50,),
            
            Expanded(
              child: Column(
                children: [
                  Text("sub title , this is very long text sub title , this is very long text sub title , this is very long text sub title , this is very long text "),
                  Text("value")
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget myTextWidget(String myText){
    /*
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          style: TextStyle(color: Colors.black),
          text: myText,
        ),
      ]),
    );

     */
    return Text(myText);
  }

}
