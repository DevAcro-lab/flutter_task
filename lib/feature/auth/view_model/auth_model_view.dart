import 'package:flutter/material.dart';
import 'package:flutter_task/configures/app_colors.dart';
import 'package:flutter_task/feature/home/view_model/home_view_model.dart';
import 'package:flutter_task/utils/widgets/toast.dart';
import 'package:provider/provider.dart';

class AuthViewModel extends ChangeNotifier {
  final CustomToastMessage _customToastMessage = CustomToastMessage();
  bool _isLoading = false;
  bool _signUpLoading = false;
  bool _isVisible = true;
  bool _isRemember = false;

  // LOGIN CREDENTIALS FIELDS CONTROLLERS
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  // SIGN UP CREDENTIALS FIELDS CONTROLLERS
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _signUpEmailController = TextEditingController();
  final TextEditingController _signUpPasswordController =
      TextEditingController();
  final TextEditingController _signUpConfirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String? _selectedGender;
  String? _phoneNumber;
  final List<Map<String, dynamic>> genders = [
    {
      "gender": "Male",
      "value": "1",
    },
    {
      "gender": "Female",
      "value": "2",
    },
    {
      "gender": "Others",
      "value": "0",
    },
  ];

  // GETTER
  bool get isLoading => _isLoading;
  bool get signUpLoading => _signUpLoading;
  bool get isVisible => _isVisible;
  bool get isRemember => _isRemember;

  //FOR LOGIN
  TextEditingController get usernameController => _loginEmailController;
  TextEditingController get passwordController => _loginPasswordController;

  //FOR SIGN UP
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get signUpEmailController => _signUpEmailController;
  TextEditingController get signUpPasswordController =>
      _signUpPasswordController;
  TextEditingController get signUpConfirmPasswordController =>
      _signUpConfirmPasswordController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  String? get selectedGender => _selectedGender;
  String? get phoneNumber => _phoneNumber;

  toggleLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  toggleSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  void setIsRememberValue(bool value) {
    _isRemember = value;
    notifyListeners();
  }

  void setGender(String value) {
    _selectedGender = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  String? emailValidator(String? value) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    String pattern = r'^.{7,}$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (!regex.hasMatch(value)) {
      return 'Password must be at least 7 characters long';
    }
    return null;
  }

  String? nameValidator(String? value) {
    String pattern = r'^[a-zA-Z]+$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    } else if (!regex.hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? confirmPasswordValidator(
      String? value, TextEditingController passwordController) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? genderValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
    }
    return null;
  }

  void loginUser(BuildContext context) {
    toggleLoading(true);
    const String userName = "user@speedforce.com";
    const String password = "password";

    final String textFieldUsername = _loginEmailController.text;
    final String textFieldPassword = _loginPasswordController.text;

    if (textFieldUsername == userName && textFieldPassword == password) {
      Future.delayed(const Duration(seconds: 2), () async {
        _customToastMessage.showToast(
          context: context,
          title: "Login successfully",
          primaryColor: AppColors.primaryColor,
          iconData: Icons.check,
        );
        try {
          await Provider.of<HomeViewModel>(context, listen: false)
              .getUserDetailsNotifier();
          Navigator.pushReplacementNamed(context, "/navbar");
        } catch (e) {
          _customToastMessage.showToast(
            context: context,
            title: "Failed to fetch user details",
            primaryColor: Colors.red,
            iconData: Icons.error_outline,
          );
        } finally {
          toggleLoading(false);
        }
      });
    } else {
      _customToastMessage.showToast(
        context: context,
        title: "Wrong Credentials",
        primaryColor: Colors.red,
        iconData: Icons.error_outline,
      );
      toggleLoading(false);
    }
  }

  void signUp(context) {
    toggleSignUpLoading(true);
    if (_selectedGender == null) {
      _customToastMessage.showToast(
          context: context,
          title: "Select Gender",
          primaryColor: Colors.red,
          iconData: Icons.error_outline);
      toggleSignUpLoading(false);
    } else if (_phoneNumber == null) {
      _customToastMessage.showToast(
          context: context,
          title: "Please enter phone number",
          primaryColor: Colors.red,
          iconData: Icons.error_outline);
      toggleSignUpLoading(false);
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () async {
          await Provider.of<HomeViewModel>(context, listen: false)
              .getUserDetailsNotifier();
          Navigator.pushReplacementNamed(context, "/navbar");
          toggleSignUpLoading(false);
        },
      );
    }
  }
}
