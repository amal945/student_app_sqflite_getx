import 'dart:io';
import 'package:final_project/controller/edit_student_controller.dart';
import 'package:final_project/controller/student_list_controller.dart';
import 'package:final_project/db/database_helper.dart';
import 'package:final_project/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditStudentPage extends StatelessWidget {
  final Student student;

  const EditStudentPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    EditStudentController controller = Get.put(EditStudentController());
    StudentListController studentListController = Get.find();
    controller.initializeValues(student);
    DataBaseHelper databaseHelp = DataBaseHelper();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Edit Student"),
      ),
      body: GetBuilder<EditStudentController>(builder: (_) {
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
                    if (img != null) {
                      _.profilePictureController.text = img.path;
                    }
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _.profilePictureController.text.isNotEmpty
                        ? FileImage(File(_.profilePictureController.text))
                        : FileImage(File(student.picture)),
                    child: _.profilePictureController.text.isEmpty
                        ? const Icon(Icons.add_a_photo)
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _.nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter valid name.";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16.0),
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
                  decoration: const InputDecoration(labelText: 'Rollnumber'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter rollnumber';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_.formKey.currentState!.validate()) {
                      final name = _.nameController.text;
                      final age = int.parse(_.ageController.text);
                      final rollnumber = int.parse(_.rollnumberController.text);
                      final parentName = _.parentNameController.text.toString();
                      final updatedStudent = Student(
                        id: student.id,
                        name: name,
                        age: age,
                        parentName: parentName,
                        rollnumber: rollnumber,
                        picture: _.profilePictureController.text,
                      );

                      databaseHelp.updateStudent(updatedStudent).then((id) {
                        if (id > 0) {
                          studentListController.refreshStudentList();
                          _.showSuccessSnackbar("Success");
                        } else {
                          _.showErrorSnackbar("Error");
                        }
                      });
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
