import 'package:flutter/material.dart';
import 'package:flutter_task/configures/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget customLoader() {
  return LoadingAnimationWidget.fourRotatingDots(
    color: AppColors.primaryColor,
    size: 50,
  );
}
