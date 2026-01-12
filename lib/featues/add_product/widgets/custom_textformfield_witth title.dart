import 'package:flutter/material.dart';
class CustomTextFormFieldWithTitle extends StatelessWidget {
  const CustomTextFormFieldWithTitle({
    super.key,
    required this.fieldLabel,
    required this.controller,
    required this.hint,
    this.suffixIcon,
    this.obscureText,
    this.validator,
  });
  final String fieldLabel, hint;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldLabel,
          style: TextStyle(
            color: Color(0XFF4E0189),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(

          obscureText: obscureText ?? false,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hint: Text(hint),
            hintStyle: TextStyle(color: Color(0xff9E9E9E)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
