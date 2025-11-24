import 'package:flutter/material.dart';
import 'package:organ_link/utils/locale/app_localization.dart';

extension ExtensionLocalization on BuildContext {
  AppLocalizations get appLocale => AppLocalizations.of(this)!;
  String get languageCode => appLocale.locale.languageCode;

  String translate(String localizationKeys) {
    return appLocale.translate(localizationKeys) ?? localizationKeys;
  }

  bool get isEnglish {
    return appLocale.locale.languageCode == codeEn;
  }
}
