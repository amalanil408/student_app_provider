import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/provider/provider.dart';
import 'package:student_app_provider/screens/add_student_screen.dart';
import 'package:student_app_provider/screens/student_detail_screen.dart';
import 'package:student_app_provider/widgets/alert.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final providerInstance = Provider.of<StudentProvider>(context, listen: true); 
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: providerInstance.students.length,
          itemBuilder: (context, index) {
            final student = providerInstance.students[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: size.width,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => StudentDetailScreen(student: student),
                    ));
                  },
                  title: Text(student.name),
                  subtitle: Text(student.phone),
                  leading: CircleAvatar(
                    backgroundImage: student.imagePath.isNotEmpty
                        ? FileImage(File(student.imagePath))
                        : const AssetImage(''),
                  ),
                  trailing: SizedBox(
                    width: 100, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDeleteConfirmationDialog(context, student.id,student.name);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => AddStudentScreen(student: student),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const AddStudentScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
