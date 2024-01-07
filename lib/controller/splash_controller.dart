import 'package:final_project/view/student_list_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    gotoHome();
  }

  Future<void> gotoHome() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(() =>  StudentListPage());
  }
}
