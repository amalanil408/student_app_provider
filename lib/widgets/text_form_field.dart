import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController textController;
  final String validatorString;
  final TextInputType type;
  const TextFormFieldWidget({super.key, required this.label, required this.textController, required this.validatorString, this.type = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      controller: textController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(label)
      ),
      validator: (value) => value!.isEmpty ? validatorString : null,
    );
  }
}

class PhoneTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final String validatorString;
  const PhoneTextFormField({super.key, required this.label, required this.textEditingController, required this.validatorString});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: textEditingController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(label)
      ),
      validator: (value) {
        if(value == null || value.isEmpty){
          return "Enter PHone no";
        } else if(!RegExp(r'^\d{10}$').hasMatch(value)){
          return "Phone number must be exactly 10 digit";
        }
        return null;
      },
    );
  }
}