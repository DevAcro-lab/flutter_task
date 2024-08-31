import 'package:flutter/material.dart';

import '../../configures/app_colors.dart';

class CustomTextFieldForSignUpView extends StatelessWidget {
  final String hintText;
  final bool showSuffix;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const CustomTextFieldForSignUpView({
    super.key,
    required this.hintText,
    required this.controller,
    this.showSuffix = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.textPrimaryColor,
            ),
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.textFieldColor,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
          suffixIcon: showSuffix ? suffixIcon : const SizedBox(),
        ),
      ),
    );
  }
}
