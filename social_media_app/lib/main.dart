import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.bottomsheets.dart';
import 'package:social_media_app/app/app.dialogs.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/ui/views/startup/startup_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const StartupView());
}
