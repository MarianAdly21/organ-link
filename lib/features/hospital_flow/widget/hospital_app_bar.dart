import 'package:flutter/material.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_app_bar_base.dart';
import 'package:organ_link/res/app_colors.dart';

class HospitalAppBar extends BaseStatelessWidget {
  const HospitalAppBar({super.key, required this.title, required this.backTap});

  final String title;
  final void Function() backTap;

  @override
  Widget baseBuild(BuildContext context) {
    return HospitalAppBarBase(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child:Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: backTap,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.blackText,
                  size: 30,
                ),
              ),
            ), 
          )
         ,  Text(title, style: context.textTheme.bodyLarge),
        ],
      ),
    );
  }
}