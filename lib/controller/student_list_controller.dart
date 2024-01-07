// ignore_for_file: avoid_print

import 'package:final_project/db/database_helper.dart';
import 'package:final_project/model/student_model.dart';
import 'package:get/get.dart';

class StudentListController extends GetxController {
  late DataBaseHelper dataBaseHelper;
  RxList students = <Student>[].obs;
  RxList filteredStudents = <Student>[].obs;
  RxBool isSearching = false.obs;

  @override
  void onInit() {
    dataBaseHelper = DataBaseHelper();
    refreshStudentList();
    super.onInit();
    update();
  }

  Future<void> refreshStudentList() async {
    update();
    try {
      final studentList = await dataBaseHelper.getStudents();
      students.assignAll(studentList);
      filteredStudents.assignAll(studentList);
      print('Student list refreshed successfully!');
    } catch (e) {
      print('Error refreshing student list: $e');
    }
  }

  void filterStudents(String query) {
    if (query.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      filteredStudents.assignAll(students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }

  void toggleSearch() {
    isSearching.toggle();
    if (!isSearching.isTrue) {
      filteredStudents.assignAll(students);
    }
  }
}
