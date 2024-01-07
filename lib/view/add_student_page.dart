// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:final_project/controller/add_student_controller.dart';
import 'package:final_project/controller/student_list_controller.dart';
import 'package:final_project/db/database_helper.dart';
import 'package:final_project/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentPage extends StatefulWidget {
  final DataBaseHelper dataBaseHelper = DataBaseHelper();

  final controller = Get.put(AddStudentController());

  AddStudentPage({
    super.key,
  });

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  @override
  Widget build(BuildContext context) {
    AddStudentController controller = Get.put(AddStudentController());
    StudentListController studentListController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add Student"),
      ),
      body: GetBuilder<AddStudentController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    XFile? img = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    _.setProfilePicture(img!.path);
                  },
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: _.profilePic != null
                        ? FileImage(File(_.profilePic!))
                        : null,
                    child: _.profilePic == null
                        ? const Icon(Icons.add_a_photo)
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _.nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Valid input";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _.ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age <= 0 || age > 100) {
                      return 'Invalid age. Age must be between 1 and 100.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _.parentNameController,
                  decoration: const InputDecoration(
                    labelText: "Parent Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Valid input";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _.rollnumberController,
                  decoration: const InputDecoration(
                    labelText: 'Rollnumber',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your rollnumber';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_.formKey.currentState!.validate()) {
                      final name = _.nameController.text;
                      final parent = _.parentNameController.text;
                      final age = int.parse(_.ageController.text);
                      final rollnumber = int.parse(_.rollnumberController.text);
                      final student = Student(
                        id: 0,
                        name: name,
                        age: age,
                        parentName: parent,
                        rollnumber: rollnumber,
                        picture: _.profilePic ?? '',
                      );
                      widget.dataBaseHelper.insertStudents(student).then((id) {
                        if (id > 0) {
                          studentListController.refreshStudentList();
                          _.showSuccessSnackbar("Success");
                        } else {
                          _.showErrorSnackbar('Failure');
                        }
                      });
                    } else {
                      _.showErrorSnackbar(
                          'Please select a gender and fill in all fields.');
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
