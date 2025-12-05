import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_app_bar_base.dart';
import 'package:organ_link/res/app_asset_paths.dart';

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
          PositionedDirectional(
            start: 0,
            child: GestureDetector(
              onTap: backTap,
              child: SvgPicture.asset(AppAssetPaths.arrowBackIcon),
            ),
          ),
          Center(child: Text(title, style: context.textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
