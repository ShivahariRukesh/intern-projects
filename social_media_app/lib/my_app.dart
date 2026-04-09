import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/services/theme_service.dart';
import 'package:social_media_app/ui/theme.dart';
import 'package:social_media_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyAppViewModel>.reactive(
      viewModelBuilder: () => MyAppViewModel(),
      onViewModelReady: (model) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          model.runStartupLogic();
        });
      },
      builder: (context, model, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [
            StackedService.routeObserver
          ],
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: model.themeMode,
          home: const StartupView(),
        );
      },
    );
  }
}

class MyAppViewModel extends ReactiveViewModel {
  final _themeService = locator<ThemeService>();
  final _sharedPreferenceService =
      locator<SharedPreferenceService>();
  ThemeMode get themeMode => _themeService.themeMode;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_themeService];

  Future runStartupLogic() async {
    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic
    _themeService.initTheme(() =>
        _sharedPreferenceService.isLightThemeMode
            ? ThemeMode.light
            : ThemeMode.dark);
  }
}
