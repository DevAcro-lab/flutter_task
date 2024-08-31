import 'package:flutter/cupertino.dart';
import 'package:flutter_task/feature/home/models/user_details.dart';
import 'package:flutter_task/utils/services/home_service.dart';
import 'package:flutter_task/utils/exceptions.dart'; // Import exceptions

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  UserDetails? _userDetails;
  String? _errorMessage;

  // GETTERS
  bool get isLoading => _isLoading;
  UserDetails? get userDetails => _userDetails;
  String? get errorMessage => _errorMessage;

  void toggleLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _resetError() {
    _errorMessage = null;
  }

  Future<void> getUserDetailsNotifier() async {
    toggleLoading(true);
    _resetError();
    try {
      final data = await _apiService.userDetails();
      debugPrint("DATA RETURNED: $data");
      debugPrint("DATA RETURNED DATA TYPE: ${data.runtimeType}");
      if (data is UserDetails) {
        _userDetails = data;
      }
    } on UnauthorizedException {
      _errorMessage = 'Unauthorized access. Please log in again.';
    } on NotFoundException {
      _errorMessage = 'User details not found.';
    } on NetworkException {
      _errorMessage =
          'Failed to connect to the server. Please check your internet connection.';
    } on ApiException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred. Please try again later.';
    } finally {
      toggleLoading(false);
      notifyListeners();
    }
  }
}
