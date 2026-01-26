import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

enum NotificationFilter { all, unread, urgent }

class NotificationFilterBar extends StatefulWidget {
  const NotificationFilterBar({super.key});

  @override
  State<NotificationFilterBar> createState() => _NotificationFilterBarState();
}

class _NotificationFilterBarState extends State<NotificationFilterBar> {
  NotificationFilter selected = NotificationFilter.all;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.notificationFilterContianerBGColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.notificationFilterContianerShadow,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _item(
            context.translate(LocalizationKeys.all),
            NotificationFilter.all,
          ),
          _item(
            context.translate(LocalizationKeys.unread),
            NotificationFilter.unread,
          ),
          _item(
            context.translate(LocalizationKeys.urgent),
            NotificationFilter.urgent,
          ),
        ],
      ),
    );
  }

  Widget _item(String title, NotificationFilter value) {
    final isSelected = selected == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selected = value);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.textColor : Colors.grey,
              fontSize: isSelected ? 16 : 14,
            ),
          ),
        ),
      ),
    );
  }
}
