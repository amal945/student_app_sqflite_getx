// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:final_project/controller/student_detail_page_controller.dart';
import 'package:final_project/controller/student_list_controller.dart';
import 'package:final_project/db/database_helper.dart';
import 'package:final_project/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class StudentDetailPage extends StatelessWidget {
  final Student student;

  StudentDetailPage({super.key, required this.student});

  DataBaseHelper db = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    StudentDetailPageController controller =
        Get.put(StudentDetailPageController());
    StudentListController studentListController = Get.find();
    print(student.parentName);
    controller.onInitialize(student);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              controller.showCustomDialog(student);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              controller.editStudent(student);
            },
          ),
        ],
      ),
      body: GetBuilder<StudentDetailPageController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 50.0,
                child: _.profilePicture.isNotEmpty
                    ? Image.file(
                        File(_.profilePicture),
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.person_outline,
                        size: 50.0,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Name: ${_.name}',
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Age: ${_.age}',
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'ParentName: ${_.parentName}',
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Rollnumber: ${_.rollNumber}',
                style: const TextStyle(fontSize: 18.0),
              ),
            )
          ],
        );
      }),
    );
  }
}
