import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_task/configures/api_urls.dart';
import 'package:flutter_task/feature/home/models/user_details.dart';
import 'package:http/http.dart' as http;
import '../api_exception_handler.dart';
import '../exceptions.dart';

class ApiService {
  UserDetails? _userDetails;

  Future<dynamic> userDetails() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiUrls.baseUrl}/login'),
      );
      final decodedData = jsonDecode(response.body);
      debugPrint("USER DETAILS: $decodedData");
      debugPrint("USER DETAILS STATUS CODE: ${response.statusCode}");
      if (response.statusCode == 200) {
        _userDetails = UserDetails.fromJson(decodedData);
        return _userDetails;
      } else {
        throw ApiExceptionHandler.handle(response.statusCode);
      }
    } on ApiException catch (e) {
    } on http.ClientException {
      throw NetworkException('Client-side error occurred');
    } catch (e) {
      throw NetworkException('Failed to connect to the server');
    }
  }
}
