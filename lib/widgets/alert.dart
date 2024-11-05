 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/provider/provider.dart';

void showDeleteConfirmationDialog(BuildContext context, String studentId,String studentName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Student"),
        content:  Text("Are you sure you want to delete this student $studentName?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Provider.of<StudentProvider>(context, listen: false).deleteStudent(studentId);
              Navigator.of(ctx).pop();
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }