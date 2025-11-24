import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organ_link/utils/app_info/package_info_cubit.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoWidget extends StatelessWidget {
  const AppInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PackageInfoCubit>(
      create: (_) => PackageInfoCubit(),
      child: BlocBuilder<PackageInfoCubit, PackageInfo?>(
        builder: (context, packageInfo) {
          if (packageInfo == null) {
            return const EmptyWidget();
          }
          return Center(
            child: Text(
              "${packageInfo.version}+${packageInfo.buildNumber}",
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
            ),
          );
        },
      ),
    );
  }
}
