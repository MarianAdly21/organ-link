import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/widget/legend_item.dart';
import 'package:organ_link/res/app_colors.dart';

class OrganDistributionChart extends StatelessWidget {
  const OrganDistributionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            LegendItem(color: AppColors.alegend1, text: "كبد (40%)"),
            LegendItem(color: AppColors.alegend2, text: "كلي يمنى (22%)"),
            LegendItem(color: AppColors.alegend3, text: "كلي يسرى (22%)"),
          ],
        ),
        SizedBox(
          height: 160.h,
          width: 160.w,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 60.r,
              sections: [
                _pieChartData(value: 40, color: AppColors.alegend1),
                _pieChartData(value: 22, color: AppColors.alegend2),
                _pieChartData(value: 16, color: AppColors.alegend3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper Method ////////////////////////
  ///////////////////////////////////////////////////////////

  PieChartSectionData _pieChartData({
    required Color color,
    required double value,
  }) {
    return PieChartSectionData(
      value: value,
      showTitle: false,
      radius: 30.r,
      color: color,
    );
  }
}
