import 'package:final_project/view/student_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStudentController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final parentNameController = TextEditingController();
  final rollnumberController = TextEditingController();

   String? profilePic = "";

  void setProfilePicture(String path) {
    profilePic = path;
    update();
  }


  void showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      messageText: const Text(
        'Operation successful',
        style: TextStyle(color: Colors.white),
      ),
      titleText: const Text(
        'Success',
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      isDismissible: true,
    );
    Get.offAll(StudentListPage());
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      messageText: const Text(
        'Operation failed',
        style: TextStyle(color: Colors.white),
      ),
      titleText: const Text(
        'Error',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      isDismissible: true,
    );
  }
}
