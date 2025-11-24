import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum AndroidStore { googlePlayStore }

class AppVersionChecker {
  /// Select The marketplace of your app
  /// default will be `AndroidStore.GooglePlayStore`
  final AndroidStore androidStore;
  final dio = Dio();
  AppVersionChecker({this.androidStore = AndroidStore.googlePlayStore});

  /// return `Current App Version Number` if update is available
  Future<String> get currentInstalledAppVersion async {
    final info = (await PackageInfo.fromPlatform());
    return "${info.version} (${info.buildNumber})";
  }

  Future<String> get currentInstalledBuildAppNumber async {
    return (await PackageInfo.fromPlatform()).buildNumber;
  }

  Future<AppCheckerResult> checkUpdate({String? minAcceptedVersion}) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final currentInstalledVersion = packageInfo.version;
    final packageName = packageInfo.packageName;

    if (Platform.isAndroid) {
      return _checkMinAcceptedVersion(
        await _checkPlayStore(currentInstalledVersion, packageName),
        minAcceptedVersion,
      );
    } else if (Platform.isIOS) {
      return _checkMinAcceptedVersion(
        await _checkAppleStore(currentInstalledVersion, packageName),
        minAcceptedVersion,
      );
    } else {
      return AppCheckerResult(
        currentInstalledVersion,
        null,
        "",
        'The target platform "${Platform.operatingSystem}" is not yet supported by this package.',
      );
    }
  }

  AppCheckerResult _checkMinAcceptedVersion(
    AppCheckerResult storeCheckingInfo,
    String? minAcceptedVersion,
  ) {
    if (minAcceptedVersion == null) {
      return storeCheckingInfo;
    } else {
      bool mustUpdate;

      /// if the current version on the store is the same as the min accepted version
      /// then the user must update to the current version
      if (storeCheckingInfo.storeVersion == minAcceptedVersion) {
        mustUpdate = true;
      } else {
        mustUpdate = AppCheckerResult.shouldUpdate(
          storeCheckingInfo.currentInstalledVersion,
          minAcceptedVersion,
        );
      }
      storeCheckingInfo.mustUpdate = mustUpdate;
      return storeCheckingInfo;
    }
  }

  Future<AppCheckerResult> _checkAppleStore(
    String currentVersion,
    String packageName,
  ) async {
    String? errorMsg;
    String? newVersion;
    String? url;
    final uri = Uri.https("itunes.apple.com", "/lookup", {
      "bundleId": packageName,
    });
    try {
      final response = await dio.getUri(uri);
      if (response.statusCode != 200) {
        errorMsg =
            "Can't find an app in the Apple Store with the id: $packageName";
      } else {
        final jsonObj = jsonDecode(response.data);
        final List results = jsonObj['results'];
        if (results.isEmpty) {
          errorMsg =
              "Can't find an app in the Apple Store with the id: $packageName";
        } else {
          newVersion = jsonObj['results'][0]['version'];
          url = jsonObj['results'][0]['trackViewUrl'];
        }
      }
    } catch (e) {
      errorMsg = "$e";
    }
    return AppCheckerResult(currentVersion, newVersion, url, errorMsg);
  }

  Future<AppCheckerResult> _checkPlayStore(
    String currentInstalledVersion,
    String packageName,
  ) async {
    String? errorMsg;
    String? storeVersion;
    String? url;
    final uri = Uri.https("play.google.com", "/store/apps/details", {
      "id": packageName,
    });
    try {
      final response = await dio.getUri(uri);
      if (response.statusCode != 200) {
        errorMsg =
            "Can't find an app in the Google Play Store with the id: $packageName";
      } else {
        storeVersion = RegExp(
          r',\[\[\["([0-9,\.]*)"]],',
        ).firstMatch(response.data)!.group(1);
        url = uri.toString();
      }
    } catch (e) {
      errorMsg = "$e";
    }
    return AppCheckerResult(
      currentInstalledVersion,
      storeVersion,
      url,
      errorMsg,
    );
  }

  /// This checks the version status, then displays a platform-specific alert
  /// with buttons to dismiss the update alert, or go to the app store.
  Future<void> showAlertIfNecessary({required BuildContext context}) async {
    final AppCheckerResult versionStatus = await checkUpdate();
    if (versionStatus.canUpdate) {
      // ignore: use_build_context_synchronously
      showUpdateDialog(context: context, appCheckerResult: versionStatus);
    }
  }

  /// Shows the user a platform-specific alert about the app update. The user
  /// can dismiss the alert or proceed to the app store.
  ///
  /// To change the appearance and behavior of the update dialog, you can
  /// optionally provide [dialogTitle], [dialogContent], [updateButtonText],
  /// [dismissButtonText], and [dismissAction] parameters.
  void showUpdateDialog({
    required BuildContext context,
    required AppCheckerResult appCheckerResult,
    String dialogTitle = 'Update Available',
    String? dialogContent,
    String updateButtonText = 'Update',
    bool allowDismissal = true,
    String dismissButtonText = 'Skip',
    TextStyle? dialogTitleStyle,
    TextStyle? dialogContentStyle,
    VoidCallback? dismissAction,
  }) async {
    final dialogTitleWidget = Text(dialogTitle, style: dialogTitleStyle);
    final dialogContentWidget = Text(
      dialogContent ??
          'You can now update this app from ${appCheckerResult.currentInstalledVersion} to ${appCheckerResult.storeVersion}',
      style: dialogContentStyle,
    );

    final updateButtonTextWidget = Text(updateButtonText);
    void updateAction() {
      launchAppStore(appCheckerResult.appURL!);
      if (allowDismissal) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    final List<Widget> actions = [
      Platform.isAndroid
          ? TextButton(onPressed: updateAction, child: updateButtonTextWidget)
          : CupertinoDialogAction(
              onPressed: updateAction,
              child: updateButtonTextWidget,
            ),
    ];

    if (allowDismissal) {
      final dismissButtonTextWidget = Text(dismissButtonText);
      dismissAction =
          dismissAction ??
          () => Navigator.of(context, rootNavigator: true).pop();
      actions.add(
        Platform.isAndroid
            ? TextButton(
                onPressed: dismissAction,
                child: dismissButtonTextWidget,
              )
            : CupertinoDialogAction(
                onPressed: dismissAction,
                child: dismissButtonTextWidget,
              ),
      );
    }

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: allowDismissal,
          child: Platform.isAndroid
              ? AlertDialog(
                  title: dialogTitleWidget,
                  content: dialogContentWidget,
                  actions: actions,
                )
              : CupertinoAlertDialog(
                  title: dialogTitleWidget,
                  content: dialogContentWidget,
                  actions: actions,
                ),
        );
      },
    );
  }

  /// Launches the Apple App Store or Google Play Store page for the app.
  Future<void> launchAppStore(String appStoreLink) async {
    debugPrint(appStoreLink);
    if (await canLaunchUrlString(appStoreLink)) {
      await launchUrlString(appStoreLink, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch appStoreLink: $appStoreLink';
    }
  }
}

class AppCheckerResult {
  /// return current app version
  final String currentInstalledVersion;

  /// return the new app version on the stores
  final String? storeVersion;

  /// return the app url
  final String? appURL;

  /// return error message if found else it will return `null`
  final String? errorMessage;

  /// return `true` if update is available
  bool mustUpdate = false;

  AppCheckerResult(
    this.currentInstalledVersion,
    this.storeVersion,
    this.appURL,
    this.errorMessage,
  );

  /// return `true` if update is available
  bool get canUpdate => shouldUpdate(
    currentInstalledVersion,
    (storeVersion ?? currentInstalledVersion),
  );

  static bool shouldUpdate(String versionA, String versionB) {
    final versionNumbersA = versionA
        .split(".")
        .map((e) => int.tryParse(e) ?? 0)
        .toList();
    final versionNumbersB = versionB
        .split(".")
        .map((e) => int.tryParse(e) ?? 0)
        .toList();

    final int versionASize = versionNumbersA.length;
    final int versionBSize = versionNumbersB.length;
    final int maxSize = math.max(versionASize, versionBSize);

    for (int i = 0; i < maxSize; i++) {
      if ((i < versionASize ? versionNumbersA[i] : 0) >
          (i < versionBSize ? versionNumbersB[i] : 0)) {
        return false;
      } else if ((i < versionASize ? versionNumbersA[i] : 0) <
          (i < versionBSize ? versionNumbersB[i] : 0)) {
        return true;
      }
    }
    return false;
  }

  @override
  String toString() {
    return "Current Version: $currentInstalledVersion\nNew Store Version: $storeVersion\nApp URL: $appURL\ncan update: $canUpdate\nerror: $errorMessage";
  }
}

/// Use this

extension CheckAppUpdate on BuildContext {
  /// Min Accepted Version;
  void checkUpdate({required String minAcceptedVersion}) async {
    final appVersionChecker = AppVersionChecker();
    final AppCheckerResult appCheckerResult = await appVersionChecker
        .checkUpdate(minAcceptedVersion: minAcceptedVersion);
    if (appCheckerResult.canUpdate && mounted) {
      appVersionChecker.showUpdateDialog(
        context: this,
        appCheckerResult: appCheckerResult,
        allowDismissal: !appCheckerResult.mustUpdate,
        dialogTitle: translate(LocalizationKeys.newVersion),
        // dialogTitleStyle: bodyMedium,
        dialogContent: translate(
          LocalizationKeys
              .weAdviseYouToInstallTheNewVersionOfTheApplicationForABetterExperience,
        ),
        dismissAction: () {
          Navigator.of(this).pop();
        },
        dismissButtonText: translate(LocalizationKeys.skip),
        updateButtonText: translate(LocalizationKeys.update),
      );
    }
  }
}
