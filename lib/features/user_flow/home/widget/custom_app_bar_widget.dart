import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';


class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Stack(
       alignment: Alignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.blackText,
                  size: 30,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: context.textTheme.bodyLarge!.copyWith(
              color: AppColors.blackText,
            ),
          ),
        ],
      ),
    );
  }
}



// class CustomAppBarWidget extends StatelessWidget {
//   const CustomAppBarWidget({super.key, required this.title, required this.onTap});
//   final String title;
//   final void Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//     //  mainAxisSize: MainAxisSize.min,
     
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(10),
//           child: GestureDetector(
//             onTap: onTap,
//             child:
//              Icon(Icons.arrow_back,
//             color: AppColors.blackText, size:30 )
//            // SvgPicture.asset(AppAssetPaths.arrowBackIcon),
//           ),
//         ),
//        // SizedBox(width: 63.w),
//         Center(
//           child: Text(
//             textAlign: TextAlign.center,
//             title,
//             style: context.textTheme.bodyLarge!.copyWith(
//               color: AppColors.blackText,
//             ),
//           ),
//         ),
//       ],
//     );

//   }
// }
