import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../configures/app_colors.dart';

class AuthAlertStatement extends StatelessWidget {
  final String text;
  final String title;
  final VoidCallback callback;
  const AuthAlertStatement({
    super.key,
    required this.text,
    required this.title,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.normal,
            ),
        children: [
          TextSpan(
            text: title,
            recognizer: TapGestureRecognizer()..onTap = callback,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  decorationColor: AppColors.primaryColor,
                ),
          ),
        ],
      ),
    );
  }
}
