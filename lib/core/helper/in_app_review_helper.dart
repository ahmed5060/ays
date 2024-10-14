import 'package:in_app_review/in_app_review.dart';

class InAppReviewHelper {
  static Future<void> openAppReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    }
  }
}
