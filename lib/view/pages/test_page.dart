import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_native_flutter/provider/crop_monitioring_provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Page"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("createMultiTemporalStatistics"),
            onTap: (){
              createMultiTemporalStatistics();
            },
          )
        ],
      ),
    );
  }

  createMultiTemporalStatistics(){
    Provider.of<CropMonitoringProvider>(context,listen: false).createMultiTemporalStatistics([[96.26189790666103,19.798514339114394],[96.26081965863705,19.80965150261819],[96.26555912196636,19.813730034242607],[96.26948989927769,19.81043315042298],[96.27634059637785,19.810200990701187],[96.27917099744081,19.80403002324653],[96.26189790666103,19.798514339114394]]);
    print(Provider.of<CropMonitoringProvider>(context,listen: false).multiTemporaalStatisticsResult);
  }
}
