import 'dart:io';
import 'package:final_project/controller/student_list_controller.dart';
import 'package:final_project/view/add_student_page.dart';
import 'package:final_project/view/student_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentListPage extends StatelessWidget {
  StudentListPage({super.key});

 final StudentListController studentlistController = Get.put(StudentListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: !studentlistController.isSearching.isTrue
              ? const Text("Student List")
              : TextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (query) {
                    studentlistController.filterStudents(query);
                  },
                  decoration: const InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white)),
                ),
          actions: [
            IconButton(
                onPressed: () {
                  studentlistController.toggleSearch();
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: studentlistController.filteredStudents.isEmpty
            ? const Center(
                child: Text("No students"),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: studentlistController.filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = studentlistController.filteredStudents[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StudentDetailPage(student: student)));
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            backgroundImage: student.picture != null &&
                                    student.picture.isNotEmpty
                                ? Image.file(File(student.picture)).image
                                : NetworkImage(
                                    'https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8189.jpg'),
                          ),
                          const SizedBox(height: 8.0),
                          Text(student.name),
                        ],
                      ),
                    ),
                  );
                }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) =>
            //           AddStudentPage(dataBaseHelper: dataBaseHelper)),
            // ).then((value) => refreshStudentList());
            // Get.to(AddStudentPage(
            //         dataBaseHelper: studentlistController.dataBaseHelper))!
            //     .then((value) => studentlistController.refreshStudentList());

            Get.to(() => AddStudentPage())!
                .then((value) => studentlistController.refreshStudentList());
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
