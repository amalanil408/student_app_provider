import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/model/model.dart';
import 'package:student_app_provider/provider/provider.dart';
import 'package:student_app_provider/widgets/constant.dart';
import 'package:student_app_provider/widgets/text_form_field.dart';

class AddStudentScreen extends StatefulWidget {
  final StudentModel? student;
  const AddStudentScreen({super.key, this.student});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _genderController = TextEditingController();
  final _addressController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _nameController.text = widget.student!.name;
      _phoneController.text = widget.student!.phone;
      _addressController.text = widget.student!.address;
      _image = widget.student!.imagePath.isNotEmpty ? File(widget.student!.imagePath) : null;
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final id = widget.student?.id ?? DateTime.now().toString();

      final newStudent = StudentModel(
        id: id,
        name: _nameController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        imagePath: _image?.path ?? '',
      );

      final studentProvider = Provider.of<StudentProvider>(context, listen: false);

      if (widget.student == null) {
        studentProvider.addStudent(newStudent);
      } else {
        studentProvider.updateStudent(id, newStudent);
      }
      
      Navigator.pop(context); 
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? "Add Student" : "Edit Student"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormFieldWidget(label: "Name", textController: _nameController, validatorString: "Enter Name"),
                  kHeight,
                  PhoneTextFormField(label: "Phone No", textEditingController: _phoneController, validatorString: "Enter phone Number"),
                  kHeight,
                  TextFormFieldWidget(label: "Address", textController: _addressController, validatorString: "Enter Address"),
                  kHeight,
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _pickImage,
                    child: _image == null
                        ? Container(
                            color: Colors.grey[200],
                            height: 150,
                            child: const Center(child: Text('Pick Image')),
                          )
                        : Image.file(_image!, height: 150),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(widget.student == null ? "Add Student" : "Update Student"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


