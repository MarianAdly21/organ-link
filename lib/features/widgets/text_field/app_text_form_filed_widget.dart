import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';

// ignore: must_be_immutable
class AppTextFormField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final String? helperText;
  final String? initialValue;
  final bool obscure;
  final bool enable;
  final AutovalidateMode? autovalidateMode;
  final void Function(String?)? onSaved;
  final void Function(String?)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final int maxLines;
  final int? maxLength;
  final String? customCounterText;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintTextStyle;
  Color? enableBorderColor;
  FocusNode? focusNode;
  Iterable<String>? autofillHints;
  final TextAlign? textAlign;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Color? fillColor;
  final Color? titleColor;

  final List<TextInputFormatter>? inputFormatters;

  AppTextFormField({
    super.key,
    this.title,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSaved,
    this.helperText,
    this.onChanged,
    this.hintTextStyle,
    this.initialValue,
    this.contentPadding,
    this.onFieldSubmitted,
    this.textInputAction,
    this.obscure = false,
    this.enable = true,
    this.maxLines = 1,
    this.maxLength,
    this.textInputType,
    this.validator,
    this.controller,
    this.inputFormatters,
    this.customCounterText,
    this.enableBorderColor,
    this.focusNode,
    this.autofillHints,
    this.autovalidateMode,
    this.textAlign = TextAlign.start,
    this.prefixIconConstraints,
    this.fillColor,
    this.titleColor,
  }) : assert(initialValue == null || controller == null);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool obscure = true;
  bool setObscure = false;

  @override
  Widget build(BuildContext context) {
    if (!setObscure) {
      obscure = widget.obscure;
      setObscure = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Text(
                widget.title!,
                style: TextStyle(
                  color: widget.titleColor ?? AppColors.blackText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            : const EmptyWidget(),
        const SizedBox(height: 10),
        TextFormField(
          autovalidateMode: widget.autovalidateMode,
          enabled: widget.enable,
          initialValue: widget.initialValue,
          obscureText: obscure,
          style: context.textTheme.bodyMedium,
          controller: widget.controller,
          autofillHints: widget.autofillHints,
          inputFormatters: widget.inputFormatters,
          focusNode: widget.focusNode,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            contentPadding: widget.contentPadding,
            prefixIconConstraints: widget.prefixIconConstraints,
            helperText: widget.helperText,
            counterText: widget.customCounterText,
            hintText: widget.hintText,
            fillColor: widget.fillColor ?? AppColors.appFormFieldFill,
            errorMaxLines: 3,
            filled: true,
            hintStyle: widget.hintTextStyle ?? context.textTheme.labelMedium,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.transparent, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: widget.enableBorderColor ?? AppColors.transparent,
                width: 2,
              ),
            ),
            errorBorder: textFormFieldErrorBorder,
            focusedErrorBorder: textFormFieldFocusErrorBorder,
            focusedBorder: textFormFieldFocusBorder,
            border: const OutlineInputBorder(),
            suffixIcon: widget.obscure
                ? IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      obscure ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  )
                : widget.suffixIcon,
          ),
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          onSaved: widget.onSaved,
          validator: widget.validator,
          maxLines: widget.maxLines,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLength: widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          textAlign: widget.textAlign!,
        ),
      ],
    );
  }

  OutlineInputBorder get textFormFieldErrorBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.formFieldProfileErrorIBorder),
  );

  OutlineInputBorder get textFormFieldFocusBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: AppColors.formFieldFocusIBorder,
      width: 2,
    ),
  );

  OutlineInputBorder get textFormFieldFocusErrorBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: AppColors.formFieldProfileErrorIBorder,
      width: 2,
    ),
  );
}
