import 'package:flutter/material.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class InternetErrorWidget extends StatelessWidget {
  const InternetErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(context.translate(LocalizationKeys.plzCheckInternet)),
    );
  }
}
