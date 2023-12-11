import 'package:flutter/material.dart';

import '../../utilities/app_styles.dart';
import 'electricity/stats_device_consumption_chart.dart';
import 'electricity/stats_electricity_usage_chart.dart';
import 'electricity/type_selection.dart';


class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  static String routeName = '/stats-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: const [
          TypeSelection(),
          SizedBox(height: 15),
          Expanded(
            child: StatsDeviceConsumptionChart(),
          ),
          SizedBox(height: 15),
          Expanded(
            child: StatsElectricityUsageChart(),
          ),
          SizedBox(height: 15),
        ],
      ),
      //bottomNavigationBar: const StatsBottomAppBar(),
    );
  }
}
