import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_native_flutter/provider/crop_monitioring_provider.dart';

class AiResultPage extends StatefulWidget {
  const AiResultPage({Key? key}) : super(key: key);

  @override
  State<AiResultPage> createState() => _AiResultPageState();
}

class _AiResultPageState extends State<AiResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI Result"),
      ),
      body: Provider.of<CropMonitoringProvider>(context,listen: false).statisticModelList != [] ?
      ListView(
        children: Provider.of<CropMonitoringProvider>(context,listen: false).statisticModelList.map((e) {
          return Card(
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                Text(e.sceneId),
                Text(e.viewId),
                Text(e.date),
                Text(e.cloud.toString()),
                Text(e.indexes!.ndvi!.average.toString())
              ],
            ),
          );
        }).toList()
      )
      :Container(),
    );
  }
}
