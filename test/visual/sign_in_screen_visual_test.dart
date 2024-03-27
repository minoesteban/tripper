import 'package:tripper/screens/sign_in/sign_in_screen.dart';

import 'visual_test_utils.dart';

void main() {
  visualTest(SignInScreen, (tester) async {
    await tester.startApp();

    await tester.matchGoldenFile();
  });
}
