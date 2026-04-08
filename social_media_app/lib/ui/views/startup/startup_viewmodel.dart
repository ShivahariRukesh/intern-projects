import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/theme_service.dart';
import 'package:stacked/stacked.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _themeService = locator<ThemeService>();

  ThemeMode get themeMode => _themeService.themeMode;

  @override
  List<ListenableServiceMixin> get listenableServices => [_themeService];
  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    _authService.isLoggedIn()
        ? _navigationService.replaceWithHomeView()
        : _navigationService.replaceWith('/auth-view');
  }
}
