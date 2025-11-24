import 'package:flutter/material.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class NoResultFoundWidget extends BaseStatelessWidget {
  final String? message;
  const NoResultFoundWidget({this.message, super.key});

  @override
  Widget baseBuild(BuildContext context) {
    return Center(
      child: Text(
        message ?? context.translate(LocalizationKeys.noData),
        textAlign: TextAlign.center,
      ),
    );
  }
}
