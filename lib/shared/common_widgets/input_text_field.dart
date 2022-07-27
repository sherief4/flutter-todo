import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

class InputTextFormField extends StatelessWidget {
  const InputTextFormField({
    Key? key,
    required this.controller,
    required this.title,
    this.hintText,
    this.suffixIcon,
    this.suffixPressed,
    this.keyboardType,
    required this.validate,
  }) : super(key: key);
  final TextEditingController controller;
  final String title;
  final String? hintText;
  final IconData? suffixIcon;
  final void Function()? suffixPressed;
  final TextInputType? keyboardType;
  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppCubit.get(context).isDark
                ? Colors.grey.shade400
                : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validate,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: IconButton(
              icon: Icon(suffixIcon),
              onPressed: suffixPressed,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
        ),
      ],
    );
  }
}
