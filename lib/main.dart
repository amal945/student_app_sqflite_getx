import 'package:final_project/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StudentRecordApp());
}

class StudentRecordApp extends StatelessWidget {
  const StudentRecordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student Record",
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}
