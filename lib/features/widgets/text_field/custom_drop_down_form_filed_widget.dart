import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';

class CustomDropDownItem extends Equatable {
  final String value;
  final String key;
  const CustomDropDownItem({required this.value, required this.key});

  @override
  List<Object?> get props => [value, key];
}

// ignore: must_be_immutable
class CustomDropDownFormFiledWidget extends StatefulWidget {
  final List<CustomDropDownItem>? items;
  final String? hintText;
  final String? title;
  final Color? enableBorderColor;
  final ValueChanged<CustomDropDownItem?>? onChanged;
  final bool ignoring;
  CustomDropDownItem? initialValue;
  final bool withBorder;
  final FormFieldSetter<CustomDropDownItem>? onSaved;
  FormFieldValidator<CustomDropDownItem>? validator;
  Color? iconColor;
  final TextStyle? hintTextStyle;
  final TextStyle? itemTextStyle;

  final double? dropdownMaxHeight;
  final FocusNode? focusNode;
  final bool enableClearSelection;

  CustomDropDownFormFiledWidget({
    super.key,
    this.items,
    this.title,
    this.itemTextStyle,
    this.enableBorderColor,
    this.ignoring = false,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.dropdownMaxHeight,
    this.initialValue,
    this.withBorder = true,
    this.iconColor,
    this.focusNode,
    this.hintTextStyle,
    this.enableClearSelection = false,
  });

  @override
  State<CustomDropDownFormFiledWidget> createState() =>
      _CustomDropDownFormFiledWidgetState();
}

class _CustomDropDownFormFiledWidgetState
    extends State<CustomDropDownFormFiledWidget> {
  CustomDropDownItem? currentValue;

  @override
  void initState() {
    currentValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: TextStyle(
              color: AppColors.formFieldTitle,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
        ],
        // widget.title != null
        //     ? Text(
        //         widget.title!,
        //         style: TextStyle(
        //           color: AppColors.formFieldTitle,
        //           fontSize: 14.sp,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       )
        //  const EmptyWidget(),
        // const SizedBox(height: 10),
        DropdownButtonFormField2<CustomDropDownItem>(
          decoration: InputDecoration(
            hintStyle:
                widget.hintTextStyle ??
                context.textTheme.labelMedium!.copyWith(
                  color: AppColors.grayText,
                ),
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 9.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color:
                    widget.enableBorderColor ??
                    AppColors.enabledAppFormFieldBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.transparent),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          focusNode: widget.focusNode,
          isExpanded: true,
          hint: currentValue != null
              ? Text(currentValue!.value)
              : Text(
                  widget.hintText ?? '',
                  style:
                      widget.hintTextStyle ??
                      context.textTheme.labelMedium!.copyWith(
                        color: AppColors.grayText,
                      ),
                ),
          buttonStyleData: const ButtonStyleData(padding: EdgeInsets.zero),
          dropdownStyleData: DropdownStyleData(
            elevation: 2,
            offset: Offset(0, -6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          iconStyleData: IconStyleData(
            icon: currentValue != null && widget.enableClearSelection
                ? ClearSelectedItemIconButton(
                    onPressed: () {
                      currentValue = null;
                      widget.onChanged?.call(null);
                      setState(() {});
                    },
                  )
                : const KeyboardArrowDownIcon(),
          ),
          items: buildDropdownList(widget.items),
          validator: widget.validator,
          value: currentValue,
          onChanged: (value) {
            currentValue = value;
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
            setState(() {});
          },
          style: TextStyle(
            color: AppColors.formFieldText,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          onSaved: widget.onSaved,
        ),
      ],
    );
  }

  List<DropdownMenuItem<CustomDropDownItem>>? buildDropdownList(
    List<CustomDropDownItem>? list,
  ) {
    return list == null || widget.ignoring
        ? null
        : list.map((CustomDropDownItem item) {
            return DropdownMenuItem<CustomDropDownItem>(
              value: item,
              child: Text(item.value, style: widget.itemTextStyle),
            );
          }).toList();
  }
}

class KeyboardArrowDownIcon extends StatelessWidget {
  const KeyboardArrowDownIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      onPressed: null,
      padding: EdgeInsets.all(0),
      icon: Icon(
        Icons.keyboard_arrow_down,
        size: 25,
        color: AppColors.grayText,
      ),
    );
  }
}

class ClearSelectedItemIconButton extends StatelessWidget {
  final void Function()? onPressed;
  const ClearSelectedItemIconButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(0),
      icon: const Icon(Icons.clear, size: 25, color: AppColors.suffixIcon),
    );
  }
}
