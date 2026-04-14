import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/models/monthly_surgery_ui_model.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/widget/legend_item.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MonthlyOperationsChart extends StatelessWidget {
  const MonthlyOperationsChart({super.key, required this.monthlySurgeriesList});

  final List<MonthlySurgeryUiModel> monthlySurgeriesList;

  @override
  Widget build(BuildContext context) {
    double rawMax = getMaxY(monthlySurgeriesList).toDouble();

    double maxY;
    double interval;

    if (rawMax <= 10) {
      maxY = 10;
      interval = 1;
    } else {
      maxY = rawMax;
      interval = 2;
    }

    // double interval = (maxY / 4).ceilToDouble();
    // if (interval == 0) interval = 1;

    return Column(
      children: [
        SizedBox(
          height: 300.h,
          child: BarChart(
            BarChartData(
              maxY: maxY,
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
                    interval: interval,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      // if (value % interval != 0) return const SizedBox();
                      if (value % interval != 0 && value != maxY) {
                        return const SizedBox();
                      }

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
                      if (value.toInt() >= monthlySurgeriesList.length) {
                        return const SizedBox();
                      }
                      return Text(
                        monthlySurgeriesList[value.toInt()].month,
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
                monthlySurgeriesList.length,
                (index) => BarChartGroupData(
                  x: index,
                  barRods: [
                    _barChartRodData(
                      toY: monthlySurgeriesList[index].totalSurgeries
                          .toDouble(),
                      color: AppColors.seconderColor,
                    ),
                    _barChartRodData(
                      toY: monthlySurgeriesList[index].successfulSurgeries
                          .toDouble(),
                      color: AppColors.mainColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LegendItem(
              color: AppColors.seconderColor,
              text: context.translate(LocalizationKeys.totalOperations),
            ),
            SizedBox(width: 16.w),
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
      strokeWidth: 0.5,
    );
  }
}

///////////////////////////////////////////////////////////
//////////////////// Helper Function //////////////////////
///////////////////////////////////////////////////////////

int getMaxY(List<MonthlySurgeryUiModel> monthlySurgeriesList) {
  int maxValue = 0;

  for (var item in monthlySurgeriesList) {
    if (item.totalSurgeries > maxValue) {
      maxValue = item.totalSurgeries;
    }
    if (item.successfulSurgeries > maxValue) {
      maxValue = item.successfulSurgeries;
    }
  }

  return maxValue;
}

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:organ_link/res/app_colors.dart';

// class MonthlyOperationsChart extends StatelessWidget {
//   const MonthlyOperationsChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     /// ✅ الداتا بتاعتك
//     final data = [
//       MonthlyOperation(month: "يونيو", total: 65, success: 60),
//       MonthlyOperation(month: "يوليو", total: 70, success: 65),
//       MonthlyOperation(month: "أغسطس", total: 48, success: 45),
//       MonthlyOperation(month: "سبتمبر", total: 58, success: 54),
//       MonthlyOperation(month: "أكتوبر", total: 50, success: 50),
//       MonthlyOperation(month: "نوفمبر", total: 70, success: 68),
//     ];

//     double rawMax = getMaxY(data);

//     double maxY;
//     double interval;

//     if (rawMax <= 10) {
//       maxY = 10;
//       interval = 1;
//     } else {
//       maxY = rawMax;
//       interval = 2;
//     }

//     return Column(
//       children: [
//         SizedBox(
//           height: 300.h,
//           child: BarChart(
//             BarChartData(
//               maxY: maxY,

//               gridData: FlGridData(
//                 show: true,
//                 drawHorizontalLine: true,
//                 drawVerticalLine: true,
//                 getDrawingVerticalLine: (value) => _getDrawingChartLines(),
//                 getDrawingHorizontalLine: (value) => _getDrawingChartLines(),
//               ),

//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(
//                   color: AppColors.grayText.withValues(alpha: 0.3),
//                 ),
//               ),

//               barTouchData: BarTouchData(enabled: false),

//               titlesData: FlTitlesData(
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     interval: interval,
//                     reservedSize: 30,
//                     getTitlesWidget: (value, meta) {
//                       // if (value % interval != 0) {
//                       //   return const SizedBox();
//                       // }
//                       if (value % interval != 0 && value != maxY) {
//                         return const SizedBox();
//                       }

//                       return Text(
//                         value.toInt().toString(),
//                         style: const TextStyle(
//                           color: AppColors.blackText,
//                           fontSize: 10,
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 rightTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),

//                 topTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),

//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (value, meta) {
//                       if (value.toInt() >= data.length) {
//                         return const SizedBox();
//                       }

//                       return Text(
//                         data[value.toInt()].month,
//                         style: const TextStyle(
//                           color: AppColors.blackText,
//                           fontSize: 10,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),

//               barGroups: List.generate(
//                 data.length,
//                 (index) => BarChartGroupData(
//                   x: index,
//                   barRods: [
//                     _barChartRodData(
//                       toY: data[index].total,
//                       color: AppColors.seconderColor,
//                     ),
//                     _barChartRodData(
//                       toY: data[index].success,
//                       color: AppColors.mainColor,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),

//         const SizedBox(height: 12),

//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             LegendItem(
//               color: AppColors.seconderColor,
//               text: "Total Operations",
//             ),
//             SizedBox(width: 16),
//             LegendItem(
//               color: AppColors.mainColor,
//               text: "Successful Operations",
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   ///////////////////////////////////////////////////////////
//   /////////////////// Helper Methods ////////////////////////
//   ///////////////////////////////////////////////////////////

//   BarChartRodData _barChartRodData({
//     required double toY,
//     required Color color,
//   }) {
//     return BarChartRodData(
//       toY: toY,
//       width: 18.w,
//       color: color,
//       borderRadius: BorderRadius.circular(4),
//     );
//   }

//   FlLine _getDrawingChartLines() {
//     return FlLine(
//       color: AppColors.grayText.withValues(alpha: 0.3),
//       strokeWidth: 0.5,
//     );
//   }
// }

// ///////////////////////////////////////////////////////////
// //////////////////// Model /////////////////////////////////
// ///////////////////////////////////////////////////////////

// class MonthlyOperation {
//   final String month;
//   final double total;
//   final double success;

//   MonthlyOperation({
//     required this.month,
//     required this.total,
//     required this.success,
//   });
// }

// ///////////////////////////////////////////////////////////
// //////////////////// Helper Function //////////////////////
// ///////////////////////////////////////////////////////////

// double getMaxY(List<MonthlyOperation> data) {
//   double maxValue = 0;

//   for (var item in data) {
//     if (item.total > maxValue) {
//       maxValue = item.total;
//     }
//     if (item.success > maxValue) {
//       maxValue = item.success;
//     }
//   }

//   return maxValue;
// }

// ///////////////////////////////////////////////////////////
// //////////////////// Legend ////////////////////////////////
// ///////////////////////////////////////////////////////////

// class LegendItem extends StatelessWidget {
//   final Color color;
//   final String text;

//   const LegendItem({super.key, required this.color, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(width: 12, height: 12, color: color),
//         const SizedBox(width: 4),
//         Text(text),
//       ],
//     );
//   }
// }
