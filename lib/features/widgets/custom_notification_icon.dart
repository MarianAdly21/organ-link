import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/res/app_asset_paths.dart';

class CustomNotificationIcon extends StatelessWidget {
  const CustomNotificationIcon({
    super.key,
    required this.onTap,
    this.height,
    this.width,
  });
  final void Function() onTap;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        height: height,
        width: width,
        AppAssetPaths.notificationIcon,
      ),
    );
  }
}
