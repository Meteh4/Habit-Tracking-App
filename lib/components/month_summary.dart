import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habitinn/datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child:Container(
        decoration: BoxDecoration(
          color: const Color(0XFFD5DEEF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: HeatMap(
            startDate: createDateTimeObject(startDate),
            endDate: DateTime.now().add(const Duration(days: 47),),
            datasets: datasets,
            colorMode: ColorMode.color,
            borderRadius: 12,
            defaultColor: Colors.grey[100],
            textColor: Colors.black,
            showColorTip: false,
            showText: true,
            scrollable: true,
            size: 32,
            colorsets: const {
              1: Color.fromARGB(20, 98, 142, 203),
              2: Color.fromARGB(40, 98, 142, 203),
              3: Color.fromARGB(60, 98, 142, 203),
              4: Color.fromARGB(80, 98, 142, 203),
              5: Color.fromARGB(100, 98, 142, 203),
              6: Color.fromARGB(120, 98, 142, 203),
              7: Color.fromARGB(150, 98, 142, 203),
              8: Color.fromARGB(180, 98, 142, 203),
              9: Color.fromARGB(220, 98, 142, 203),
              10: Color.fromARGB(255, 98, 142, 203),
            },
          ),
      ),
      );
  }
}