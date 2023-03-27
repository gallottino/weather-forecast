import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  int x;
  double y;

  ChartData(this.x, this.y);
}

class TemperatureGraph extends StatelessWidget {

  final List<double> chartData;
  const TemperatureGraph({Key? key, required this.chartData}) : super(key: key);
  
  
  List<ChartData> calculateChartData() {
    return List<ChartData>.from(chartData.asMap().entries.map((entry) => ChartData(entry.key, entry.value)).toList());
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 150,
      child: SfCartesianChart(
        primaryYAxis: CategoryAxis(isVisible: false),
        primaryXAxis: CategoryAxis(isVisible: false),
        title: ChartTitle(text: "Temperature"),
        series: <ChartSeries<ChartData, double>>[
          LineSeries(
              dataSource: calculateChartData(),
              color: Colors.amber,
              xValueMapper: (ChartData data, _) => data.x.toDouble(),
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.top)),
          AreaSeries(
              dataSource: calculateChartData(),
              color: Colors.yellow.withAlpha(65),
              xValueMapper: (ChartData data, _) => data.x.toDouble(),
              yValueMapper: (ChartData data, _) => data.y)
        ],
      ),
    );
  }
}
