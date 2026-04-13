import 'package:social_media_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:social_media_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:social_media_app/ui/views/home/home_view.dart';
import 'package:social_media_app/ui/views/home/widgets/comment_sheet.dart';
import 'package:social_media_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:social_media_app/ui/views/auth/auth_view.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/theme_service.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/services/post_service.dart';
import 'package:social_media_app/services/image_cache_service.dart';
import 'package:social_media_app/ui/views/story_screen/story_screen_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: StoryScreenView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: ThemeService),
    InitializableSingleton(classType: SharedPreferenceService),
    LazySingleton(classType: PostService),
    LazySingleton(classType: ImageCacheService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: CommentSheet)
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
