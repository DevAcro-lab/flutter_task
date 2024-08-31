import 'package:flutter/material.dart';
import '../../configures/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback callBack;
  final bool loading;
  const CustomButton({
    super.key,
    required this.title,
    required this.callBack,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: callBack,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.primaryColor,
        ),
        alignment: Alignment.center,
        child: loading
            ? const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              )
            : Text(
                title,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
      ),
    );
  }
}
