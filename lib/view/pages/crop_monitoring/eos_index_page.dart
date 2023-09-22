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
                Container(
                  color: Colors.blue,
                    child: Text(e.date)),
                // Text(e.sceneId),
                // Text(e.viewId),
                //
                // Text(e.cloud.toString()),
                Divider(),

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
                Text("NDVI"),
                ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: Provider.of<CropMonitoringProvider>(context,listen: false).cropMonitoringIndexList.map((f) {
                    return Column(
                      children: [
                        e.indexes!.msi!.q1 <= f.maxValue && e.indexes!.msi!.q1 >= f.minValue && f.type == "NDVI" ? Row(
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
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :Container(),
                        e.indexes!.msi!.q3 <= f.maxValue && e.indexes!.msi!.q3 >= f.minValue && f.type == "NDVI" ? Row(
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
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :Container(),
                        e.indexes!.msi!.max <= f.maxValue && e.indexes!.msi!.max >= f.minValue && f.type == "NDVI" ? Row(
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
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :Container(),
                        e.indexes!.msi!.min <= f.maxValue && e.indexes!.msi!.min >= f.minValue && f.type == "NDVI" ? Row(
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
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :Container(),
                        e.indexes!.msi!.p10 <= f.maxValue && e.indexes!.msi!.p10 >= f.minValue && f.type == "NDVI" ? Row(
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
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :Container(),
                        e.indexes!.msi!.p90 <= f.maxValue && e.indexes!.msi!.p90 >= f.minValue && f.type == "NDVI" ? Row(
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
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :Container(),
                        e.indexes!.msi!.std <= f.maxValue && e.indexes!.msi!.std >= f.minValue && f.type == "NDVI" ? Row(
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
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :Container(),
                        e.indexes!.msi!.median <= f.maxValue && e.indexes!.msi!.median >= f.minValue && f.type == "NDVI" ? Row(
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
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :Container(),
                        e.indexes!.msi!.average <= f.maxValue && e.indexes!.msi!.average >= f.minValue && f.type == "NDVI" ? Row(
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
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :Container(),
                        e.indexes!.msi!.variance <= f.maxValue && e.indexes!.msi!.variance >= f.minValue && f.type == "NDVI" ? Row(
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
                                Text(f.mmDescription,textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ) :Container(),
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
}
