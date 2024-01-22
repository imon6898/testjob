import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/login_model.dart';

class UserController extends GetxController {
  RxString username = ''.obs;

  void setUsername(String name) {
    username.value = name;
  }
}

class AuthService {
  final String apiUrl =
      'https://peanut.ifxdb.com/api/ClientCabinetBasic/IsAccountCredentialsCorrect';

  Future<AccountCredentials> fetchLogin(int login, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json-patch+json',
        },
        body: json.encode({
          'login': login,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Save the login data in SharedPreferences
        await saveLoginData(responseData);

        // Update the username in AuthService
        await setUsername();

        return AccountCredentials.fromJson(responseData);
      } else {
        // Handle non-200 response codes
        print('Login failed. Response code: ${response.statusCode}');
        return AccountCredentials(success: false, token: '');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error during login: $error');
      return AccountCredentials(success: false, token: '');
    }
  }

  Future<void> saveLoginData(Map<String, dynamic> loginData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', loginData['token'] ?? '');
      prefs.setString('username', loginData['username'] ?? '');
    } catch (error) {
      print('Error saving login data: $error');
    }
  }

  Future<void> setUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Get.find<UserController>().setUsername(prefs.getString('username') ?? '');
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}