import 'package:flutter/material.dart';
import 'package:organ_link/utils/feedback/feedback_snackbar.dart';
import 'package:organ_link/utils/feedback/feedback_toast.dart';

void showFeedbackMessage(
  String message, {
  FeedbackStyle feedbackStyle = FeedbackStyle.toast,
  BuildContext? context,
}) {
  switch (feedbackStyle) {
    case FeedbackStyle.toast:
      showToast(message);
      break;
    case FeedbackStyle.snackBar:
      if (context != null) {
        showSnackBarMassage(message, context);
      }
      break;
  }
}

enum FeedbackStyle { toast, snackBar }
