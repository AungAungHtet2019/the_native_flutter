import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_native_flutter/provider/crop_monitioring_provider.dart';

class EosIndexPage extends StatefulWidget {
  const EosIndexPage({Key? key}) : super(key: key);

  @override
  State<EosIndexPage> createState() => _EosIndexPageState();
}

class _EosIndexPageState extends State<EosIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ရည်ညွှန်းချက်"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Provider.of<CropMonitoringProvider>(context,listen: false).statisticModelList != [] ?
      ListView(
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
                      ],

                    );
                  }).toList(),
                ),

                Divider(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("သီးနှံအထွက်နှုန်း(EVI)",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: Provider.of<CropMonitoringProvider>(context,listen: false).cropMonitoringIndexList.map((f) {
                    return Column(
                      children: [
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
                        e.indexes!.evi!.average <= f.maxValue && e.indexes!.evi!.average >= f.minValue && f.type == "NDRE" ? Row(
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

                                Text(e.indexes!.evi!.average.toString(),textAlign: TextAlign.start,),
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
                      ],

                    );
                  }).toList(),
                ),

                Divider(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("သီးနှံကြီးထွားမှုနှင့်မြေသြဇာလိုအပ်ချက်(MSI)",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: Provider.of<CropMonitoringProvider>(context,listen: false).cropMonitoringIndexList.map((f) {
                    return Column(
                      children: [
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
                        e.indexes!.msi!.average <= f.maxValue && e.indexes!.msi!.average >= f.minValue && f.type == "MSAVI" ? Row(
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

                                Text(e.indexes!.msi!.average.toString(),textAlign: TextAlign.start,),
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
      )
      :Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget myTextWidget(String myText){
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          style: TextStyle(color: Colors.black),
          text: myText,
        ),
      ]),
    );
  }
}
