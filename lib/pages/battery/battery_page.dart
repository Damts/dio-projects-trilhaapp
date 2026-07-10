import 'package:battery_plus/battery_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  var battery = Battery();
  var statusBateria = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
    battery.onBatteryStateChanged.listen((BatteryState state) {
      debugPrint("State: $state");
    });
  }

  void _loadData() async {
     statusBateria = await battery.batteryLevel;
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${'BATERIA'.tr()}: $statusBateria%"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20,
                animationDuration: 2000,
                percent: statusBateria / 100,
                center: Text("$statusBateria%"),
                progressColor: Colors.greenAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}