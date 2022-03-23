import 'package:get/get.dart';

class ReviewsController extends GetxController {
  var isReviewsOpen = false.obs;

  void toggleReview() {
    isReviewsOpen.toggle();
  }
}
