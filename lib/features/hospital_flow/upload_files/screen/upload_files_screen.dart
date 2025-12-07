import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_dialog_widget.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/upload_files/screen/upload_report_confarmation_screen.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_base_body_scaffold.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/text_field/custom_drop_down_form_filed_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class UploadFilesScreen extends BaseStatefulScreenWidget {
  const UploadFilesScreen({super.key});

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _UploadFilesScreenState();
}

class _UploadFilesScreenState extends BaseScreenState<UploadFilesScreen> {
  List<File> pickedFiles = [];
  final TextEditingController dateController = TextEditingController();

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: _buildBody(),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody() {
    return HospitalBaseBodyScaffold(
      titleOfScreen: LocalizationKeys.reportNewTitle,
      backTap: () {},
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _headerWidget(),
            _reportDetailsSection(),
            _importantNotes(),
            _btnRow(),
          ],
        ),
      ),
    );
  }

  Widget _btnRow() {
    return Row(
      children: [
        Expanded(
          child: AppButtonWithGradientColors(
            onTap: () {
              _uploadReportConfirmation();
            },
            borderRadius: 8,
            text: context.translate(LocalizationKeys.uploadButton),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: AppButtonWithGradientColors(
            onTap: () {},
            borderRadius: 8,
            border: Border.all(color: AppColors.backButtonBorder),
            text: context.translate(LocalizationKeys.cancelButton),
            textColor: AppColors.blackText,
            colors: [AppColors.backButtonBG, AppColors.backButtonBG],
          ),
        ),
      ],
    );
  }

  Widget _importantNotes() {
    return Container(
      margin: EdgeInsets.only(bottom: 40.h),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      height: 90.h,
      decoration: BoxDecoration(
        color: AppColors.importantInfContainerBG,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.translate(LocalizationKeys.importantInfoTitle),
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.translate(LocalizationKeys.importantInfoText),
            style: TextStyle(
              color: AppColors.seconderColor,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.translate(LocalizationKeys.reportDetails),
          style: context.textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        _chooseFileType(),

        _examinationDate(),

        _uploadFileSection(),

        _additionalNotes(),
      ],
    );
  }

  Widget _additionalNotes() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.translate(LocalizationKeys.additionalNotesLabel),
          style: context.textTheme.labelMedium!.copyWith(
            color: AppColors.blackText,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8.h, bottom: 24.h),
          height: 56.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.blackText.withValues(alpha: 0.15),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            maxLines: null,
            //  minLines: 8,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            style: context.textTheme.labelMedium!.copyWith(
              color: AppColors.blackText,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: context.translate(
                LocalizationKeys.additionalNotesLPlaceholder,
              ),
              hintStyle: context.textTheme.labelMedium!.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: AppColors.notesBG,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 8.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _examinationDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.translate(LocalizationKeys.examDate),
          style: context.textTheme.labelMedium!.copyWith(
            color: AppColors.blackText,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
          child: SizedBox(
            height: 38,
            child: TextFormField(
              controller: dateController,
              readOnly: true,

              style: context.textTheme.labelMedium!.copyWith(
                color: AppColors.blackText,
                fontSize: 13,
              ),
              decoration: InputDecoration(
                hintText: context.translate(LocalizationKeys.datMonthYear),
                filled: true,
                fillColor: Colors.white,
                hoverColor: Colors.white,
                focusColor: Colors.white,
                suffixIcon: IconButton(
                  padding: EdgeInsetsDirectional.only(end: 13.w),
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  icon: Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: AppColors.grayText,
                  ),
                  onPressed: _showDatePickerOnTap,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onTap: _showDatePickerOnTap,
            ),
          ),
        ),
      ],
    );
  }

  Widget _chooseFileType() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: CustomDropDownFormFiledWidget(
        title: context.translate(LocalizationKeys.reportType),
        hintText: context.translate(LocalizationKeys.chooseReportType),
        itemTextStyle: context.textTheme.labelMedium!.copyWith(
          color: AppColors.blackText,
        ),
        items: [
          CustomDropDownItem(value: "تحاليل الدم", key: ""),
          CustomDropDownItem(value: "تحاليل الدم", key: ""),
          CustomDropDownItem(value: "تحاليل الدم", key: ""),
        ],
      ),
    );
  }

  Widget _headerWidget() {
    return ContainerWithShadow(
      borderRadius: 24,
      padding: EdgeInsets.only(top: 0, bottom: 24.h),
      contentPadding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [
          Text(
            "أحمد محمد العلي",
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              "${context.translate(LocalizationKeys.fileNumber)} 12345",
              style: context.textTheme.labelMedium!.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _uploadFileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        Text(
          context.translate(LocalizationKeys.fileLabel),
          style: context.textTheme.labelMedium!.copyWith(
            color: AppColors.blackText,
          ),
        ),
        ContainerWithShadow(
          height: 150,
          padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          child: GestureDetector(
            onTap: () {
              pick();
            },
            child: Column(
              children: [
                SvgPicture.asset(AppAssetPaths.uploadIcon),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    context.translate(LocalizationKeys.pickFile),
                    style: context.textTheme.labelMedium!.copyWith(
                      color: AppColors.blackText,
                    ),
                  ),
                ),
                Text(
                  "PDF, DICOM, JPG, PNG (حتى 50 MB)",
                  style: context.textTheme.labelMedium!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////

  Future<void> pick() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["pdf", "jpg", "png", "dicom"],
      );
      if (result != null) {
        setState(() {
          pickedFiles.add(File(result.files.single.path!));
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _showDatePickerOnTap() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.scaffoldBackground,
              onPrimary: AppColors.blackText,
              onSurface: AppColors.textColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.blackText),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      dateController.text =
          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
    }
  }

  Future<void> _uploadReportConfirmation() {
    return showAppDialog(
      context: context,
      contentPadding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 16.w),
      dialogWidget: UploadReportConfirmationDialogScreen(),
      shouldPopCallback: () {
        return true;
      },
    );
  }
}
