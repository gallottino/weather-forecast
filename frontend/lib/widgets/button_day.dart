import 'package:flutter/material.dart';

class DayButton extends StatefulWidget {
  final String day;
  final double min;
  final double max;
  final Function? onClick;
  const DayButton(
      {Key? key, required this.day, required this.min, required this.max, this.onClick})
      : super(key: key);

  @override
  State<DayButton> createState() => _DayButtonState();
}

class _DayButtonState extends State<DayButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onClick?.call();
      },
      child: Column(
        children: [
          Text(widget.day),
          const Image(image: AssetImage('asset/icons/rain.png')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.max.toStringAsFixed(1)}°",
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
              Container(width: 4),
              Text(
                "${widget.min.toStringAsFixed(1)}°",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
