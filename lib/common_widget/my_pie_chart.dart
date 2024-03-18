import 'package:fifthproject/core/classes/my_new_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

import '../core/model/pie_chart_model.dart';
import '../theme.dart';

class MyPieChart extends StatefulWidget {
  const MyPieChart({super.key});

  @override
  State<MyPieChart> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  ApiClient _api = ApiClient();
  List? pieChardata;

  Future<List> initData() async {
    print("I enter to initData method in BottomBarView page ");
    var res = await _api.getPieChart();
    pieChardata = res;
    print("the response from initData method is ${res}");
    print(
        "if you can see me , this means that the request send and you must see the data that is ${pieChardata}");
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    // Static PieChartData
    List<PieChartData> pieChartData = [
      PieChartData("Food", 32),
      PieChartData("Leisure", 30),
      PieChartData("Medicin", 45),
      PieChartData("Cloths", 35),
      PieChartData("Transport", 60),
    ];
    List<PieChartData> pieChartData0 = [
      PieChartData("Food", 0),
      PieChartData("Leisure", 0),
      PieChartData("Medicin", 0),
      PieChartData("Cloths", 0),
      PieChartData("Transport", 0),
    ];
    return FutureBuilder(
      future: initData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data!.isNotEmpty) {
          return PieChart(
            dataMap: Map.fromIterable(snapshot.data!,
                key: (data) => data["expense_type"],
                value: (data) => data["sum"].toDouble()),
            animationDuration: Duration(milliseconds: 800),
            chartRadius: MediaQuery.of(context).size.width / 1.8,
            chartType: ChartType.ring,
            ringStrokeWidth: 45,
            chartLegendSpacing: 40,
            legendOptions: LegendOptions(
                showLegendsInRow: true,
                legendPosition: LegendPosition.bottom,
                legendTextStyle: TextStyle(color: TColor.white)),
            chartValuesOptions: ChartValuesOptions(
              chartValueStyle: TextStyle(color: TColor.white),
              showChartValueBackground: false,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
            ),
          );
        }
        if (snapshot.data!.isEmpty) {
          return PieChart(
            dataMap: Map.fromIterable(pieChartData0,
                key: (data) => data.label, value: (data) => data.value),
            animationDuration: Duration(milliseconds: 800),
            chartRadius: MediaQuery.of(context).size.width / 1.8,
            chartType: ChartType.ring,
            ringStrokeWidth: 45,
            chartLegendSpacing: 40,
            legendOptions: LegendOptions(
                showLegendsInRow: true,
                legendPosition: LegendPosition.bottom,
                legendTextStyle: TextStyle(color: TColor.white)),
            chartValuesOptions: ChartValuesOptions(
              chartValueStyle: TextStyle(color: TColor.white),
              showChartValueBackground: false,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
