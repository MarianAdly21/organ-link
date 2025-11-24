import 'package:flutter/material.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/features/widgets/text_field/custom_drop_down_form_filed_widget.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';
import 'package:organ_link/utils/validations/validator.dart';

mixin AppValidate {
  String? textValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateText(value);
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.wrongFormat);
      case ValidationState.valid:
        return null;
    }
  }

  String? dropDownValidator(BuildContext context, CustomDropDownItem? value) {
    final ValidationState validationState = Validator.validateText(value?.key);
    switch (validationState) {
      case ValidationState.empty:
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.required);
      case ValidationState.valid:
        return null;
    }
  }

  String? textValidatorWithLength(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateTextWithLength(
      value,
    );
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.wrongFormat);
      case ValidationState.valid:
        return null;
    }
  }

  String? iBANValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateIBAN(value);
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.wrongFormat);
      case ValidationState.valid:
        return null;
    }
  }

  String? numberValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateNumber(value);
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.wrongFormat);
      case ValidationState.valid:
        return null;
    }
  }

  String? numberValidatorWithLength(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateNumberWithLength(
      value,
    );
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.wrongFormat);
      case ValidationState.valid:
        return null;
    }
  }

  String? nationalIdValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateNumberWithLength(
      value,
      length: 14,
    );
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.wrongFormat);
      case ValidationState.valid:
        return null;
    }
  }

  String? decimalNumberValidator(BuildContext context, String? value) {
    final ValidationState validationState = Validator.validateDecimal(value);
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return context.translate(LocalizationKeys.wrongFormat);
      case ValidationState.valid:
        return null;
    }
  }

  String? validateNumberRange(
    BuildContext context,
    String? value, {
    int min = 1,
    int max = 100,
  }) {
    final ValidationState validationState = Validator.validateNumberRange(
      value,
      min: min,
      max: max,
    );
    switch (validationState) {
      case ValidationState.empty:
        return context.translate(LocalizationKeys.required);
      case ValidationState.formatting:
        return "${context.translate(LocalizationKeys.enterNumberlessThan)} $max";
      case ValidationState.valid:
        return null;
    }
  }
}
