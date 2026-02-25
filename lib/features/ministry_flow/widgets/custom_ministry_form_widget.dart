import 'package:flutter/material.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/features/widgets/text_field/app_text_form_filed_widget.dart';
import 'package:organ_link/res/app_colors.dart';

class CustomMinistryFormWidget extends StatefulWidget {
  const CustomMinistryFormWidget({
    super.key,
    required this.fullNameTitle,
    required this.phoneTitle,
    required this.emailTitle,
    required this.positionTitle,
    this.fullNameHint,
    this.phoneHint,
    this.emailHint,
    this.positionHint,
    this.onChangedfullName,
    this.onChangedPhone,
    this.onChangedEmail,
    this.onChangedPosition,
  });

  final String fullNameTitle;
  final String phoneTitle;
  final String emailTitle;
  final String positionTitle;
  final void Function(String)? onChangedfullName;
  final void Function(String)? onChangedPhone;
  final void Function(String)? onChangedEmail;
  final void Function(String)? onChangedPosition;

  final String? fullNameHint;
  final String? phoneHint;
  final String? emailHint;
  final String? positionHint;
  @override
  State<CustomMinistryFormWidget> createState() =>
      _CustomMinistryFormWidgetState();
}

class _CustomMinistryFormWidgetState extends State<CustomMinistryFormWidget> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: _textField(
              title: widget.fullNameTitle,
              hintText: widget.fullNameHint,
              onChanged: widget.onChangedfullName,
            ),
          ),
          _textField(
            title: widget.phoneTitle,
            hintText: widget.phoneHint,
            onChanged: widget.onChangedPhone,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: _textField(
              title: widget.emailTitle,
              hintText: widget.emailHint,
              onChanged: widget.onChangedEmail,
            ),
          ),
          _textField(
            title: widget.positionTitle,
            hintText: widget.positionHint,
            onChanged: widget.onChangedPosition,
          ),
        ],
      ),
    );
  }

  Widget _textField({
    required String title,
    void Function(String)? onChanged,
    String? hintText,
  }) {
    return AppTextFormField(
      title: context.translate(title),
      enableBorderColor: AppColors.enableBorderColorSetting,
      fillColor: AppColors.filledColorEnable,
      titleColor: AppColors.grayText,
      hintText: hintText,
      hintTextStyle: context.textTheme.labelMedium!.copyWith(
        color: AppColors.textColor,
      ),
      onChanged: onChanged,
    );
  }
}
