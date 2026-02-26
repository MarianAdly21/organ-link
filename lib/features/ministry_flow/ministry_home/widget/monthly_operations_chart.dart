import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/widget/legend_item.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MonthlyOperationsChart extends StatelessWidget {
  const MonthlyOperationsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300.h,
          child: BarChart(
            BarChartData(
              maxY: 80,
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: true,
                getDrawingVerticalLine: (value) {
                  return _getDrawingChartLines();
                },
                getDrawingHorizontalLine: (value) {
                  return _getDrawingChartLines();
                },
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: AppColors.grayText.withValues(alpha: 0.3),
                ),
              ),
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 20,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          color: AppColors.blackText,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        data[value.toInt()].month,
                        style: const TextStyle(
                          color: AppColors.blackText,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(
                data.length,
                (index) => BarChartGroupData(
                  x: index,
                  barRods: [
                    _barChartRodData(
                      toY: data[index].total,
                      color: AppColors.seconderColor,
                    ),
                    _barChartRodData(
                      toY: data[index].success,
                      color: AppColors.mainColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LegendItem(
              color: AppColors.seconderColor,
              text: context.translate(LocalizationKeys.totalOperations),
            ),
            SizedBox(width: 16),
            LegendItem(
              color: AppColors.mainColor,
              text: context.translate(
                LocalizationKeys.successfulOperationCount,
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper Method ////////////////////////
  ///////////////////////////////////////////////////////////

  BarChartRodData _barChartRodData({
    required double toY,
    required Color color,
  }) {
    return BarChartRodData(
      toY: toY,
      width: 18.w,
      color: color,
      borderRadius: BorderRadius.circular(0),
    );
  }

  FlLine _getDrawingChartLines() {
    return FlLine(
      color: AppColors.grayText.withValues(alpha: 0.3),
      strokeWidth: 0.49,
      dashArray: null,
    );
  }
}

final data = [
  MonthlyOperation(month: "يونيو", total: 65, success: 60),
  MonthlyOperation(month: "يوليو", total: 70, success: 65),
  MonthlyOperation(month: "أغسطس", total: 48, success: 45),
  MonthlyOperation(month: "سبتمبر", total: 58, success: 54),
  MonthlyOperation(month: "أكتوبر", total: 50, success: 50),
  MonthlyOperation(month: "نوفمبر", total: 70, success: 68),
];

class MonthlyOperation {
  final String month;
  final double total;
  final double success;

  MonthlyOperation({
    required this.month,
    required this.total,
    required this.success,
  });
}
