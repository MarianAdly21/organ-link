import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/extensions/screen_sizer_extension.dart';
import 'package:organ_link/_core/widgets/base_dialog_widget.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/upload_files/bloc/upload_report_file_bloc.dart';
import 'package:organ_link/features/hospital_flow/upload_files/model/upload_report_file_ui_model.dart';
import 'package:organ_link/features/hospital_flow/upload_files/screen/upload_report_confarmation_screen.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/text_field/custom_drop_down_form_filed_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';
import 'package:organ_link/utils/validations/app_validate.dart';
import 'package:path/path.dart' as p;

class UploadFilesScreen extends StatelessWidget {
  const UploadFilesScreen({
    super.key,
    required this.userId,
    required this.fileNumber,
    required this.name,
  });
  final int userId;
  final String fileNumber;
  final String name;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadReportFileBloc(),
      child: UploadFilesScreenWithBloc(
        userId: userId,
        fileNumber: fileNumber,
        name: name,
      ),
    );
  }
}

class UploadFilesScreenWithBloc extends BaseStatefulScreenWidget {
  const UploadFilesScreenWithBloc({
    super.key,
    required this.userId,
    required this.fileNumber,
    required this.name,
  });
  final int userId;
  final String fileNumber;
  final String name;
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _UploadFilesScreenWithBlocState();
}

class _UploadFilesScreenWithBlocState
    extends BaseScreenState<UploadFilesScreenWithBloc>
    with AppValidate {
  File? pickedFiles;
  final TextEditingController _dateController = TextEditingController();
  String? _reportType;
  String? _reportName;
  String? _examDate;
  // late int _userId;
  String? _description;
  // File? _file;
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: LocalizationKeys.reportNewTitle,
        backTap: () {
          Navigator.pop(context);
        },
        body: BlocConsumer<UploadReportFileBloc, UploadReportFileState>(
          listener: (context, state) {
            if (state is UploadReportFileErrorState) {
              showLoading();
            } else {
              hideLoading();
            }
            if (state is UploadReportFileValidatedState) {
              _currentBloc.add(
                UploadReportDataEvent(
                  uploadReportFileUiModel: UploadReportFileUiModel(
                    reportType: _reportType!,
                    reportName: _reportName!,
                    examDate: _examDate!,
                    userId: widget.userId,
                    description: _description,
                    file: pickedFiles!,
                  ),
                ),
              );
            } else if (state is UploadReportFileSuccessfullyState) {
              _uploadReportConfirmation();
            } else if (state is UploadReportFileErrorState &&
                state.codeError != 1016) {
              showFeedbackMessage(state.errorMessage);
            } else if (state is UploadReportFileNotValidatedState) {
              showFeedbackMessage(
                context.translate(
                  LocalizationKeys.pleaseFillInAllRequiredFields,
                ),
              );
            }
          },
          builder: (context, state) {
            return _buildBody();
          },
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
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
              _currentBloc.add(
                ValidateReportDateEvent(
                  reportFile: pickedFiles,
                  reportType: _reportType,
                  reportName: _reportName,
                  examDate: _examDate,
                ),
              );
              // _uploadReportConfirmation();
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
      //  height: 90.h,
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
        _chooseReportType(),
        _chooseReportName(),
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
          margin: EdgeInsets.only(
            top: 8.h,
            bottom: 24.h,
            left: 4.w,
            right: 4.w,
          ),
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
            onSaved: _onDescriptionSaved,
          ),
        ),
      ],
    );
  }

  Widget _examinationDate() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
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
              height: 38.h,
              child: TextFormField(
                controller: _dateController,
                readOnly: true,
                style: context.textTheme.labelMedium!.copyWith(
                  color: AppColors.blackText,
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  hintText: context.translate(LocalizationKeys.datMonthYear),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 9.h,
                  ),
                  hintStyle: context.textTheme.labelMedium!.copyWith(
                    color: AppColors.grayText,
                  ),
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
                onSaved: _onExamDateSaved,
                // validator: (value) => textValidator(context, value),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chooseReportName() {
    return CustomDropDownFormFiledWidget(
      title: context.translate(LocalizationKeys.reportName),
      hintText: context.translate(LocalizationKeys.chooseReportName),
      itemTextStyle: context.textTheme.labelMedium!.copyWith(
        color: AppColors.blackText,
      ),
      items: [
        CustomDropDownItem(
          value: "تحليل الدم الكامل",
          key: "تحليل الدم الكامل",
        ),
        CustomDropDownItem(value: "تقرير طبي شامل", key: "تقرير طبي شامل"),
        CustomDropDownItem(value: "اخري", key: "اخري"),
      ],
      onSaved: _onChooseReportNameSaved,
      // validator: (value) => dropDownValidator(context, value),
    );
  }

  Widget _chooseReportType() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: CustomDropDownFormFiledWidget(
        title: context.translate(LocalizationKeys.reportType),
        hintText: context.translate(LocalizationKeys.chooseReportType),
        itemTextStyle: context.textTheme.labelMedium!.copyWith(
          color: AppColors.blackText,
        ),
        items: [
          CustomDropDownItem(value: "أشعة", key: "أشعة"),
          CustomDropDownItem(value: "تحاليل", key: "تحاليل"),
          CustomDropDownItem(value: "تقرير طبي", key: "تقرير طبي"),
        ],
        onSaved: _onChooseReportTypeSaved,
        //  validator: (value) => dropDownValidator(context, value),
      ),
    );
  }

  Widget _headerWidget() {
    return ContainerWithShadow(
      borderRadius: 24,
      width: context.width,
      padding: EdgeInsets.only(top: 4.h, bottom: 24.h, left: 2.w, right: 2.w),
      contentPadding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [
          Text(
            widget.name,
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              "${context.translate(LocalizationKeys.fileNumber)} ${widget.fileNumber}",
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
          width: context.width,
          padding: EdgeInsets.only(
            top: 8.h,
            bottom: 24.h,
            left: 2.w,
            right: 2.w,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
          child: pickedFiles == null
              ? GestureDetector(
                  onTap: () {
                    _pickFile();
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(AppAssetPaths.uploadIcon),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
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
                )
              : Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 40),
                    SizedBox(height: 10.h),
                    Text(
                      p.basename(pickedFiles!.path),
                      style: context.textTheme.labelMedium!.copyWith(
                        color: AppColors.blackText,
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  void _onChooseReportTypeSaved(CustomDropDownItem? value) {
    _reportType = value?.key;
  }

  void _onChooseReportNameSaved(CustomDropDownItem? value) {
    _reportName = value?.key;
  }

  void _onExamDateSaved(String? newValue) {
    _examDate = newValue;
  }

  void _onDescriptionSaved(String? newValue) {
    _description = newValue;
  }

  UploadReportFileBloc get _currentBloc => context.read<UploadReportFileBloc>();

  Future<void> _pickFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["pdf", "jpg", "png", "dicom"],
      );
      if (result != null) {
        setState(() {
          pickedFiles = File(result.files.single.path!);
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
      _dateController.text =
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
