import 'package:flutter/material.dart';

class SummaryForecast extends StatelessWidget {
  final double temp;
  final double precipitation;
  final double humidity;
  final double wind;

  const SummaryForecast(
      {Key? key,
      required this.temp,
      required this.precipitation,
      required this.humidity,
      required this.wind})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 50),
        SizedBox(
          width: 120,
          child: Row(
            children: const [
              Image(image: AssetImage('asset/icons/sunny.png')),
              Text("15°", style: TextStyle(fontSize: 34)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
              'Precipitation: $precipitation%',
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 12),
            ),
            Text("Humidity: $humidity%",
                textAlign: TextAlign.right, style: const TextStyle(fontSize: 12)),
            Text("Wind: $wind km/h",
                textAlign: TextAlign.right, style: const TextStyle(fontSize: 12))
          ],
        ),
        const SizedBox(
          width: 100,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: const [
          Text(
            "Weather",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("Monday"),
          Text("Sunny")
        ])
      ],
    );
  }
}
