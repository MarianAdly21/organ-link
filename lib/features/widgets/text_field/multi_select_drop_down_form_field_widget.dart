import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';

class CustomMultiSelectDropDownItem extends Equatable {
  final String value;
  final String key;
  const CustomMultiSelectDropDownItem({required this.value, required this.key});

  @override
  List<Object?> get props => [value, key];
}

class MultiSelectDropDownFormFieldWidget extends BaseStatelessWidget {
  const MultiSelectDropDownFormFieldWidget({
    required this.items,
    this.title,
    this.hintText,
    this.hintTextStyle,
    this.showClearIcon = false,
    this.prefixIcon,
    this.borderRadius,
    this.selectedItemBackgroundColor,
    this.searchEnabled = false,
    this.enabled = true,
    this.controller,
    this.onChanged,
    super.key,
  });
  final List<CustomMultiSelectDropDownItem> items;
  final String? title;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final bool showClearIcon;
  final Widget? prefixIcon;
  final double? borderRadius;
  final Color? selectedItemBackgroundColor;
  final bool searchEnabled;
  final bool enabled;
  final MultiSelectController<CustomMultiSelectDropDownItem>? controller;
  final void Function(List<CustomMultiSelectDropDownItem>)? onChanged;

  @override
  Widget baseBuild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(
                title!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.filterTitles,
                ),
              )
            : const EmptyWidget(),
        const SizedBox(height: 10),
        MultiDropdown<CustomMultiSelectDropDownItem>(
          items: buildDropdownList(items),
          controller: controller,
          enabled: enabled,
          searchEnabled: searchEnabled,
          onSelectionChange: onChanged,
          chipDecoration: ChipDecoration(
            backgroundColor: selectedItemBackgroundColor,
            wrap: true,
            runSpacing: 2,
            spacing: 10,
          ),
          fieldDecoration: FieldDecoration(
            hintText: hintText ?? '',
            hintStyle: hintTextStyle ?? context.textTheme.labelMedium,
            prefixIcon: prefixIcon,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              size: 25.h,
              color: AppColors.suffixIcon,
            ),
            showClearIcon: showClearIcon,
            border: multiSelectDropDownFormFieldBorder,
            focusedBorder: multiSelectDropDownFormFieldFocusedBorde,
          ),
          dropdownDecoration: DropdownDecoration(
            maxHeight: 300.h,
            elevation: 10,
          ),
          dropdownItemDecoration: DropdownItemDecoration(
            selectedIcon: const Icon(
              Icons.check_box,
              color: AppColors.multiDropDownSelectedItemIcon,
            ),
            disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder get multiSelectDropDownFormFieldBorder =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        borderSide: const BorderSide(color: AppColors.multiDropDownBorder),
      );

  OutlineInputBorder get multiSelectDropDownFormFieldFocusedBorde =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        borderSide: const BorderSide(color: AppColors.multiDropDownFocusBorder),
      );

  List<DropdownItem<CustomMultiSelectDropDownItem>> buildDropdownList(
    List<CustomMultiSelectDropDownItem> list,
  ) {
    return list.map((e) => DropdownItem(value: e, label: e.value)).toList();
  }
}
