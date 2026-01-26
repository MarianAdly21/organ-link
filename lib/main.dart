import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/app_router.dart';
import 'package:organ_link/features/hospital_flow/hospital_dashboard/screen/hospital_dashboard_screen.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/utils/bloc_observer/app_bloc_observer.dart';
import 'package:organ_link/utils/device_info/device_info.dart';
import 'package:organ_link/utils/locale/app_localization.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';
import 'package:organ_link/utils/locale/locale_cubit.dart';
import 'package:organ_link/utils/locale/locale_repository.dart';
import 'package:organ_link/utils/secure_storage/secure_storage.dart';
import 'package:organ_link/utils/status_bar/statusbar_controller.dart';
import 'package:organ_link/utils/theme/app_theme.dart';
import 'package:organ_link/utils/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  //await FilePicker.platform.clearTemporaryFiles();

  /// setup GetIt Instances ...
  GetIt.I.registerLazySingleton<PreferencesManager>(() => PreferencesManager());
  GetIt.I.registerLazySingleton<DioApiManager>(
    () => DioApiManager(
      preferenceManager: GetIt.I<PreferencesManager>(),
      failToRefreshTokenCallback: _failedToRefreshToken,
    ),
  );

  GetIt.I.registerLazySingleton<SecureStorage>(() => SecureStorage());
  GetIt.I.registerLazySingleton<DeviceInfo>(() => DeviceInfo());

  Bloc.observer = AppBlocObserver();

  runApp(const OrganLink());
}

void _failedToRefreshToken() {
  GetIt.I<PreferencesManager>().clearData();
  // TODO: navigate to login screen if failure
  // AppRouter.mainNavigatorKey.currentState?.pushNamedAndRemoveUntil(
  //   LoginScreen.routeName,
  //   (_) => false,
  // );
}

class OrganLink extends StatefulWidget {
  const OrganLink({super.key});

  @override
  State<OrganLink> createState() => _OrganLinkState();
}

class _OrganLinkState extends State<OrganLink> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (context) => LocaleCubit(
            LocaleRepository(preferenceManager: GetIt.I<PreferencesManager>()),
          ),
        ),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, BaseAppTheme>(
        builder: (context, appThemeState) {
          _changeStatusBarColor(appThemeState);
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, state) {
              return ScreenUtilInit(
                designSize: const Size(375, 812),
                builder: (context, child) {
                  return MediaQuery.withClampedTextScaling(
                    minScaleFactor: 0.8,
                    maxScaleFactor: 1.2,
                    child: MaterialApp(
                      onGenerateTitle: (BuildContext context) =>
                          AppLocalizations.of(
                            context,
                          )?.translate(LocalizationKeys.appName) ??
                          "OrganLink",
                      debugShowCheckedModeBanner: false,
                      theme: appThemeState.themeDataLight,
                      darkTheme: appThemeState.themeDataDark,
                      themeMode: ThemeMode.light,

                      /// the list of our supported locals for our app
                      /// currently we support only 2 English and Arabic ...
                      supportedLocales: AppLocalizations.supportedLocales,

                      /// these delegates make sure that the localization data
                      /// for the proper
                      /// language is loaded ...
                      localizationsDelegates: const [
                        /// A class which loads the translations from JSON files
                        AppLocalizations.delegate,

                        /// Built-in localization of basic text
                        ///  for Material widgets in Material
                        GlobalMaterialLocalizations.delegate,

                        /// Built-in localization for text direction LTR/RTL
                        GlobalWidgetsLocalizations.delegate,

                        /// Built-in localization for text direction LTR/RTL in Cupertino
                        GlobalCupertinoLocalizations.delegate,

                        DefaultCupertinoLocalizations.delegate,
                      ],
                      locale: state,
                      navigatorKey: AppRouter.mainNavigatorKey,

                      routes: AppRouter.routes,
                      home: HospitalDashboardScreen(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _changeStatusBarColor(BaseAppTheme appThemeState) {
    setStatusBarColor(appThemeState.themeDataLight.primaryColor);
  }
}
