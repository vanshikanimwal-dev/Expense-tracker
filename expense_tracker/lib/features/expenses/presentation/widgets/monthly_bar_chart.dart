import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MonthlyBarChart extends StatelessWidget {
  const MonthlyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Monthly Overview', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 1.7,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(['Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb'][value.toInt()],
                              style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
                        ),
                      ),
                    ),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: _generateGroups(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateGroups() {
    // These mock values represent the twin bars in the reference
    final data = [
      [12.0, 8.0], [15.0, 10.0], [14.0, 9.0], [17.0, 11.0], [13.0, 8.0], [18.0, 6.0]
    ];

    return List.generate(data.length, (i) => BarChartGroupData(
      x: i,
      barRods: [
        BarChartRodData(toY: data[i][0], color: AppColors.primaryTeal, width: 8, borderRadius: BorderRadius.circular(4)),
        BarChartRodData(toY: data[i][1], color: AppColors.expenseRed.withOpacity(0.6), width: 8, borderRadius: BorderRadius.circular(4)),
      ],
    ));
  }
}