import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organ_link/utils/locale/app_localization.dart';
import 'package:organ_link/utils/locale/locale_repository.dart';

class LocaleCubit extends Cubit<Locale> {
  final BaseLocaleRepository localeRepository;

  LocaleCubit(this.localeRepository) : super(const Locale(codeEn)) {
    getDefaultLocale();
  }

  void changeLocale(LocaleApp selectedLanguage) async {
    final defaultLanguageCode = await localeRepository.getLanguageLocal();
    if (selectedLanguage == LocaleApp.ar && defaultLanguageCode != codeAr) {
      await localeRepository.updateLanguageInfo(LocaleApp.ar);
      emit(const Locale(codeAr));
    } else if (selectedLanguage == LocaleApp.en &&
        defaultLanguageCode != codeEn) {
      await localeRepository.updateLanguageInfo(LocaleApp.en);
      emit(const Locale(codeEn));
    }
  }

  void getDefaultLocale() async {
    final defaultLanguageCode = await localeRepository.getLanguageLocal();
    Locale locale;
    if (defaultLanguageCode == null) {
      locale = Locale(defaultSystemLocale);
      await localeRepository.changeLanguageLocal(
        LocaleApp.fromStringKey(defaultSystemLocale),
      );
    } else {
      locale = Locale(defaultLanguageCode);
      await localeRepository.changeLanguageLocal(
        LocaleApp.fromStringKey(defaultLanguageCode),
      );
    }
    emit(locale);
  }

  String get defaultSystemLocale => Platform.localeName.substring(0, 2);
}

enum LocaleApp {
  en,
  ar;

  String mapToApiKey() {
    switch (this) {
      case LocaleApp.en:
        return "english";
      case LocaleApp.ar:
        return "arabic";
    }
  }

  String mapToPreferenceKey() {
    switch (this) {
      case LocaleApp.en:
        return codeEn;
      case LocaleApp.ar:
        return codeAr;
    }
  }

  static LocaleApp fromStringKey(String key) {
    switch (key) {
      case codeAr:
        return LocaleApp.ar;
      default:
        return LocaleApp.en;
    }
  }
}
