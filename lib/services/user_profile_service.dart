import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../utils/utils.dart'; // Import utils

class UserProfileService {
  Future<UserProfile?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';

    final url = '${APIUtils.baseUrl}/get_user_profile.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['success']) {
        print('Response body: ${response.body}');
        return UserProfile.fromJson(data['result']);
      } else {
        throw Exception('Failed to load user profile');
      }
    } else {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<bool> updateUserProfile(UserProfile profile) async {
    final url = Uri.parse('${APIUtils.baseUrl}/update_user_profile.php'); // Use APIUtils.baseUrl

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userName': profile.userName, // Thêm tham số userName
          'fullName': profile.fullName,
          'dateOfBirth': profile.dateOfBirth,
          'gender': profile.gender,
          'nationality': profile.nationality,
          'phoneNumber': profile.phoneNumber,
          'emailAddress': profile.emailAddress,
        }),
      );
      print('Response body: ${response.body}');
      final responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        return true;
      } else {
        print('Error: ${responseData['message']}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}

