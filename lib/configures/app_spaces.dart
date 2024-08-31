import 'package:flutter/material.dart';

class AppSpaces {
  AppSpaces._();

  static SizedBox smallSpace(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.01;
    return SizedBox(height: height);
  }

  static SizedBox smallMedSpace(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.02;
    return SizedBox(height: height);
  }

  static SizedBox mediumSpace(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.03;
    return SizedBox(height: height);
  }

  static SizedBox largeSpace(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.05;
    return SizedBox(height: height);
  }
}
