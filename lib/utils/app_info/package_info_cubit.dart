import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoCubit extends Cubit<PackageInfo?> {
  PackageInfoCubit() : super(null) {
    _getPackageInfo();
  }

  FutureOr<void> _getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    emit(packageInfo);
  }
}
