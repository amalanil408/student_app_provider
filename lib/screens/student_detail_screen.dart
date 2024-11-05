import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app_provider/model/model.dart';
import 'package:student_app_provider/widgets/detail_row.dart';

class StudentDetailScreen extends StatelessWidget {
  final StudentModel? student;
  
  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Detail"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(File(student!.imagePath)), 
                backgroundColor: Colors.blue.shade100,
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDetailRow(Icons.person, "Name", student!.name),
                      const SizedBox(height: 10),
                      buildDetailRow(Icons.phone, "Phone", student!.phone),
                      const SizedBox(height: 10),
                      buildDetailRow(Icons.home, "Address", student!.address),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
