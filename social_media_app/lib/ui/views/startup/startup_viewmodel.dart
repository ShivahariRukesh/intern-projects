import 'package:flutter/material.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/services/theme_service.dart';
import 'package:stacked/stacked.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _themeService = locator<ThemeService>();
  final _sharedPreferenceService =
      locator<SharedPreferenceService>();

  ThemeMode get themeMode => _themeService.themeMode;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_themeService];
  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic
    _sharedPreferenceService.isUserLoggedIn
        ? _navigationService.replaceWithHomeView()
        : _navigationService.replaceWithAuthView();
  }
}
