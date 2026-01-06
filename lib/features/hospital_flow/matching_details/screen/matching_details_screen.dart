import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_base_body_scaffold.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/res/app_colors.dart';

class MatchingDetailsScreen extends BaseStatefulScreenWidget {
  const MatchingDetailsScreen({super.key});
  static const routName = "/matching-details-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MatchingDetailsScreenState();
}

class _MatchingDetailsScreenState
    extends BaseScreenState<MatchingDetailsScreen> {
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: HospitalBaseBodyScaffold(
        titleOfScreen: "Matching Details",
        backTap: () {
          Navigator.pop(context);
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ContainerWithShadow(
                //height: 258.h,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 24.h,
                  horizontal: 16.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DataRowWithDivider(
                      divider: true,
                      title: "اسم المريض",
                      subTitle: "أحمد محمد العلي",
                    ),
                    DataRowWithDivider(
                      divider: true,
                      title: "رقم الملف",
                      subTitle: "P001",
                    ),
                    DataRowWithDivider(
                      divider: true,
                      title: "العضو المطلوب",
                      subTitle: "كلي",
                    ),
                    DataRowWithDivider(
                      divider: true,
                      title: "تاريخ الطلب",
                      subTitle: "2025-10-2",
                    ),
                    DataRowWithDivider(
                      title: "حالة الطلب",
                      subTitle: "تمت المطابقة",
                    ),
                  ],
                ),
              ),
              Text(
                "نتيجة الذكاء الاصطناعي",
                style: context.textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _matchingResultAi(),
              _waitingAiResultContainer(),/// if 
            ],
          ),
        ),
      ),
    );
  }

  Widget _matchingResultAi() {
    return ContainerWithShadow(
              background: AppColors.matchingDataUserContainerBG,
              contentPadding: EdgeInsets.symmetric(
                vertical: 24.h,
                horizontal: 16.w,
              ),
              child: Column(
                children: [
                  DataRowWithDivider(
                    divider: true,
                    dividerColor: AppColors.matchingDataUserDivider,
                    title: "اسم المتبرع",
                    subTitle: "سارة أحمد",
                  ),
                  DataRowWithDivider(
                    divider: true,
                    dividerColor: AppColors.matchingDataUserDivider,
                    title: "رقم الملف",
                    subTitle: "P001",
                  ),
                  DataRowWithDivider(
                    divider: true,
                    dividerColor: AppColors.matchingDataUserDivider,
                    title: "فصيلة الدم",
                    subTitle: "+A",
                  ),
                  DataRowWithDivider(
                    isImportant: true,
                    dividerColor: AppColors.matchingDataUserDivider,
                    title: "نسبة التطابق",
                    subTitle: "%95",
                    importantTextColor: AppColors.matchingParentage,
                  ),
                ],
              ),
            );
  }

  Widget _waitingAiResultContainer() {
    return ContainerWithShadow(
      height: 88.h,
      background: AppColors.waitingAiResultBG,
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Text(
        textAlign: TextAlign.center,
        "جارٍ تحليل البيانات بواسطة الذكاء الاصطناعي... النتيجة ستظهر خلال 24-48 ساعة",
        style: context.textTheme.labelMedium!.copyWith(
          color: AppColors.textColor,
        ),
      ),
    );
  }
}
