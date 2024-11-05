import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app_provider/model/model.dart';

class StudentProvider with ChangeNotifier{
  Box<StudentModel> studentBox = Hive.box<StudentModel>('students');

  List<StudentModel> get students => studentBox.values.toList();

  void addStudent(StudentModel student){
    studentBox.put(student.id, student);
    notifyListeners();
  }

  void updateStudent(String id , StudentModel updateStudent){
    studentBox.put(id, updateStudent);
    notifyListeners();
  }

  void deleteStudent(String id){
    studentBox.delete(id);
    notifyListeners();
  }

  StudentModel? getStudent(String id){
    return studentBox.get(id);
  }
}