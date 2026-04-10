import 'package:flutter_test/flutter_test.dart';
import 'package:social_media_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ImageCacheServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
