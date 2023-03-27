import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/api/api_handler.dart';
import 'package:frontend/widgets/button_day.dart';
import 'package:frontend/widgets/summary_forecast.dart';

import 'widgets/temperature_graph.dart';

void main() {
  runApp(const Launcher());
}

class Launcher extends StatelessWidget {
  const Launcher({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: ForecastApp(title: 'Flutter Demo Home Page'));
  }
}

class ForecastApp extends StatefulWidget {
  const ForecastApp({super.key, required this.title});

  final String title;

  @override
  State<ForecastApp> createState() => _ForecastAppState();
}

class _ForecastAppState extends State<ForecastApp> {
  bool loading = true;
  var days = {};
  int currentDay = 0;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    var res = await ApiHandler.getForecast(45.0703, 7.6869);

    setState(() {
      days = res;
      loading = false;
    });
  }

  List<Widget> DaysWidget() {
    List<Widget> res = [const SizedBox(width: 80,)];
    for(var day in days["days"]) {
      res.add(DayButton(day: day["weather"], min: day["min"], max: day["max"]));
      res.add(const SizedBox(width: 5,));
    }
    return res;
  }

  List<double> getChartData() {
    List<double> res = List<double>.from(days["days"][currentDay]["data"] as List);
    for(int i = res.length; i < 5; i++) {
      res.add(days["days"][currentDay + 1]["data"][i - res.length]);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: 500,
      child: days.isEmpty ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Your weather forecast on demand!"),
              SpinKitSpinningLines(size: 40,color: Colors.amber)],
          )
      ) : Column(
        children: [
          Row(
            children: [SummaryForecast(
              temp: days["days"][currentDay]["temp"],
              wind: days["days"][currentDay]["wind"],
              humidity: days["days"][currentDay]["humidity"],
              precipitation: days["days"][currentDay]["precipitation"] * 100,
            )],
          ),
          TemperatureGraph(chartData: getChartData()),
          Row(
            children: DaysWidget()
          ),
        ],
      ),
    ));
  }
}
