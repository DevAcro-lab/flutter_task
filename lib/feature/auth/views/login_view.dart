import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/configures/app_colors.dart';
import 'package:flutter_task/configures/app_spaces.dart';
import 'package:flutter_task/feature/auth/view_model/auth_model_view.dart';
import 'package:flutter_task/feature/auth/views/signup_view.dart';
import 'package:flutter_task/utils/assets.dart';
import 'package:provider/provider.dart';

import '../../../utils/widgets/auth_alert_statement.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/reuseable_social_content.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final GlobalKey<FormState> _uniqueLoginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Consumer<AuthViewModel>(
              builder: (context, authNotifier, child) {
                return Form(
                  key: _uniqueLoginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back_outlined,
                          ),
                        ),
                      ),
                      AppSpaces.smallSpace(context),
                      Image(
                        width: s.width * 0.76,
                        image: const AssetImage(
                          AppAssets.logo,
                        ),
                      ),
                      AppSpaces.mediumSpace(context),
                      Text("Welcome Back",
                          style: Theme.of(context).textTheme.headlineSmall),
                      AppSpaces.mediumSpace(context),
                      buildTextFormField(
                        context: context,
                        controller: authNotifier.usernameController,
                        hintText: "Email",
                        prefixIconUrl: AppAssets.messageIcon,
                        validator: (value) {
                          return authNotifier.emailValidator(value);
                        },
                      ),
                      AppSpaces.smallSpace(context),
                      AppSpaces.smallSpace(context),
                      buildTextFormField(
                        context: context,
                        controller: authNotifier.passwordController,
                        hintText: "Password",
                        prefixIconUrl: AppAssets.passwordIcon,
                        showSuffix: true,
                        validator: authNotifier.passwordValidator,
                        isVisible: authNotifier.isVisible,
                        suffix: authNotifier.isVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        suffixIconCallback: () {
                          authNotifier.toggleVisibility();
                        },
                      ),
                      AppSpaces.smallSpace(context),
                      rememberMeWidget(context),
                      AppSpaces.smallSpace(context),
                      CustomButton(
                        title: 'Log in',
                        callBack: () {
                          if (_uniqueLoginFormKey.currentState!.validate()) {
                            authNotifier.loginUser(context);
                          }
                        },
                        loading: authNotifier.isLoading,
                      ),
                      AppSpaces.mediumSpace(context),
                      Text(
                        "Forgot the password?",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      AppSpaces.largeSpace(context),
                      const ReUseAbleSocialContent(),
                      AppSpaces.mediumSpace(context),
                      AuthAlertStatement(
                        text: "Don't have an account  ",
                        title: 'Sign Up',
                        callback: () =>
                            Navigator.of(context).pushNamed('/signup'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget rememberMeWidget(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authNotifier, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: authNotifier.isRemember,
              onChanged: (value) {
                authNotifier.setIsRememberValue(value!);
              },
              activeColor: AppColors.primaryColor,
              shape: const RoundedRectangleBorder(),
              side: const BorderSide(color: AppColors.primaryColor, width: 1.7),
            ),
            Text(
              "Remember me",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }

  Widget buildTextFormField({
    required BuildContext context,
    required String hintText,
    required String prefixIconUrl,
    required TextEditingController controller,
    IconData? suffix,
    VoidCallback? suffixIconCallback,
    bool showSuffix = false,
    bool isVisible = false,
    String? Function(String?)? validator,
  }) {
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
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.textPrimaryColor,
            ),
        obscureText: isVisible,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.textFieldColor,
          contentPadding: const EdgeInsets.only(top: 12),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
          prefixIcon: SvgPicture.asset(
            prefixIconUrl,
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
          ),
          suffixIcon: showSuffix
              ? IconButton(
                  onPressed: suffixIconCallback,
                  icon: Icon(
                    suffix,
                    size: 20,
                    color: AppColors.textFieldSuffixColor,
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
