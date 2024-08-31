import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/configures/app_spaces.dart';
import 'package:flutter_task/feature/auth/view_model/auth_model_view.dart';
import 'package:flutter_task/feature/auth/views/login_view.dart';
import 'package:flutter_task/utils/assets.dart';
import 'package:flutter_task/utils/widgets/custom_button.dart';
import 'package:flutter_task/utils/widgets/reuseable_social_content.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../configures/app_colors.dart';
import '../../../utils/widgets/auth_alert_statement.dart';
import '../../../utils/widgets/custom_textfield.dart';

class ServiceProviderTab extends StatefulWidget {
  ServiceProviderTab({super.key});

  @override
  State<ServiceProviderTab> createState() => _ServiceProviderTabState();
}

class _ServiceProviderTabState extends State<ServiceProviderTab> {
  final GlobalKey<FormState> _uniqueSignUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Consumer<AuthViewModel>(
        builder: (context, authNotifier, child) {
          return Form(
            key: _uniqueSignUpFormKey,
            child: Column(
              children: [
                AppSpaces.mediumSpace(context),
                CustomTextFieldForSignUpView(
                  hintText: 'First Name',
                  controller: authNotifier.firstNameController,
                  validator: (value) {
                    return authNotifier.nameValidator(value);
                  },
                ),
                AppSpaces.smallMedSpace(context),
                CustomTextFieldForSignUpView(
                  hintText: 'Last Name',
                  controller: authNotifier.lastNameController,
                  validator: (value) {
                    return authNotifier.nameValidator(value);
                  },
                ),
                AppSpaces.smallMedSpace(context),
                CustomTextFieldForSignUpView(
                  hintText: 'Email',
                  showSuffix: true,
                  suffixIcon: SvgPicture.asset(
                    AppAssets.mailIcon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                  controller: authNotifier.signUpEmailController,
                  validator: (value) {
                    return authNotifier.emailValidator(value);
                  },
                ),
                AppSpaces.smallMedSpace(context),
                buildGenderField(s, authNotifier, context),
                AppSpaces.smallMedSpace(context),
                buildPhoneNumberField(context, authNotifier),
                AppSpaces.smallMedSpace(context),
                CustomTextFieldForSignUpView(
                  hintText: 'Password',
                  showSuffix: true,
                  suffixIcon: SvgPicture.asset(
                    AppAssets.passIcon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                  controller: authNotifier.signUpPasswordController,
                  validator: (value) {
                    return authNotifier.passwordValidator(value);
                  },
                ),
                AppSpaces.smallMedSpace(context),
                CustomTextFieldForSignUpView(
                  hintText: 'Confirm Password',
                  showSuffix: true,
                  suffixIcon: SvgPicture.asset(
                    AppAssets.passIcon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                  controller: authNotifier.signUpConfirmPasswordController,
                  validator: (value) {
                    return authNotifier.confirmPasswordValidator(
                      value,
                      authNotifier.signUpPasswordController,
                    );
                  },
                ),
                AppSpaces.mediumSpace(context),
                buildSecurityTextContent(context),
                AppSpaces.mediumSpace(context),
                CustomButton(
                  title: "Sign Up",
                  callBack: () {
                    if (_uniqueSignUpFormKey.currentState!.validate()) {
                      authNotifier.signUp(context);
                    }
                  },
                  loading: authNotifier.signUpLoading,
                ),
                AppSpaces.mediumSpace(context),
                AuthAlertStatement(
                  text: 'Already have an account  ',
                  title: 'Log in',
                  callback: () =>
                      Navigator.of(context).pushReplacementNamed('/login'),
                ),
                AppSpaces.mediumSpace(context),
                const ReUseAbleSocialContent(),
              ],
            ),
          );
        },
      ),
    );
  }

  IntlPhoneField buildPhoneNumberField(
      BuildContext context, AuthViewModel authViewModel) {
    return IntlPhoneField(
      controller: authViewModel.phoneNumberController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textFieldColor,
        hintText: "Enter phone number",
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
        contentPadding: const EdgeInsets.only(top: 12),
        counter: const SizedBox(),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
        ),
        border: InputBorder.none,
      ),
      initialCountryCode: 'PK',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.textPrimaryColor,
          ),
      onChanged: (phone) {
        authViewModel.setPhoneNumber(phone.completeNumber);
        debugPrint("Phone: ${phone.completeNumber}");
      },
    );
  }

  SizedBox buildGenderField(
      Size s, AuthViewModel authNotifier, BuildContext context) {
    return SizedBox(
      height: s.height * 0.059,
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              const Icon(
                Icons.person,
                color: AppColors.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Select gender',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: authNotifier.genders
              .map((Map<String, dynamic> gender) => DropdownMenuItem<String>(
                    value: gender["value"],
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          gender["gender"] ?? "Unknown",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.textPrimaryColor,
                                    fontSize: 13,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ))
              .toList(),
          value: authNotifier.selectedGender,
          onChanged: (String? value) {
            authNotifier.setGender(value!);
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.borderSideColor.withOpacity(0.6),
              ),
              color: AppColors.whiteColor,
            ),
            elevation: 0,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.lightBlue,
            ),
            iconSize: 16,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: s.width - 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.whiteColor,
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme: const ScrollbarThemeData(
              radius: Radius.circular(40),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }

  RichText buildSecurityTextContent(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "By continuing you agree to our ",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
          children: [
            TextSpan(
              text: "Terms of Service",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textFieldSuffixColor,
                  ),
            ),
            TextSpan(
              text: " and ",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
            ),
            TextSpan(
              text: "Privacy Policy",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textFieldSuffixColor,
                  ),
            ),
          ]),
    );
  }
}
