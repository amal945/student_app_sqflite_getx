import 'package:final_project/controller/student_list_controller.dart';
import 'package:final_project/db/database_helper.dart';
import 'package:final_project/model/student_model.dart';
import 'package:final_project/view/edit_student_page.dart';
import 'package:final_project/view/student_list_page.dart';
import 'package:final_project/view/widgets/delete_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentDetailPageController extends GetxController {
  late DataBaseHelper db;

  @override
  void onInit() {
    super.onInit();
    db = DataBaseHelper();
  }

  late String name;
  late String parentName;
  late int age;
  late int rollNumber;
  late String profilePicture;

  onInitialize(Student data) {
    name = data.name;
    parentName = data.parentName;
    age = data.age;
    rollNumber = data.rollnumber;
    profilePicture = data.picture;
    update();
  }

  void deleteStudent(Student student) {
    print(student.name);
    Get.defaultDialog(
      title: 'Delete Student',
      content: const Text(
        'Are you sure you want to delete this student?',
        style: TextStyle(color: Colors.white),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      titlePadding: const EdgeInsets.only(top: 25, bottom: 10),
      titleStyle: const TextStyle(color: Colors.white),
      middleTextStyle: const TextStyle(color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 57, 57, 57),
      onConfirm: () {
        Get.snackbar(
          'Success',
          'Student added successfully',
          messageText: const Text(
            'Student Deleted Successfully',
            style: TextStyle(color: Colors.white),
          ),
          titleText: const Text(
            'Deleted',
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          isDismissible: true,
        );

        db.deleteStudent(student.id);
        Get.find<StudentListController>().refreshStudentList();
        Get.offUntil(MaterialPageRoute(builder: (context) => StudentListPage()),
            (route) => false);
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  void editStudent(Student student) {
    Get.to(() => EditStudentPage(student: student))?.then((_) => Get.back());
  }

  void showCustomDialog(Student student) {
    Get.dialog(DeleteDialog(onCancel: () {
      Get.back();
    }, onDelete: () {
      Get.snackbar(
        'Success',
        'Student added successfully',
        messageText: const Text(
          'Student Deleted Successfully',
          style: TextStyle(color: Colors.white),
        ),
        titleText: const Text(
          'Deleted',
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.grey,
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        isDismissible: true,
      );

      db.deleteStudent(student.id);
      Get.offAll(() => StudentListPage());
    }));
  }
}
