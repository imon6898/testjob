import 'package:testjob/config/api_routes.dart';
import 'package:testjob/models/get_account_information_response_model.dart';
import 'package:testjob/services/cache/cache_manager.dart';
import 'package:testjob/services/network/http_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../Custom_widget/custom_text_field.dart';
import '../../models/get_open_trades_response_model.dart';
import '../../models/last_four_number_model.dart';
import '../../services/network/api_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/login_model.dart';
import '../home_page/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  bool passwordVisible = false;

  void _loginPressed() async {

    final result = await HttpRequests.postJson(ApiRoutes.userLogin, body: {
      "email": userEmailController.text,
      "password": passwordController.text,
      "device_name": "mobile"
    }, isLoginTime: true);

    var accountInfo = GetAccountInformationResponse.fromJson(result);
    final AccountCredentials loginResult = AccountCredentials.fromJson(result);

    // final AccountCredentials loginResult = await authService.fetchLogin(login, password);

    // Handle the result as needed
    if (loginResult.success == true) {
      // Successful login
      HttpRequests.setToken(loginResult.token!);
      HttpRequests.setLoginEmail(userEmailController.text);
      CacheManager.setUserName(loginResult.user!.name!);

      // Navigate to the home page
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(username: "")));
    } else {
      // Unsuccessful login
      print('Login failed. Message: Login failed.'); // Adjust this message as needed
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Dismiss the keyboard when the user taps outside any input field
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Lottie.asset(
                'assets/login_page_animation.json',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 180,
                              width: 180,
                              child: Lottie.asset(
                                'assets/animation_login.json',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomTextFields(
                              controller: userEmailController,
                              labelText: 'Email',
                              hintText: 'Email',
                              disableOrEnable: true,
                              borderColor: 0xFFBCC2C2,
                              filled: false,
                              prefixIcon: Icons.email,
                            ),
                            CustomTextFields(
                              controller: passwordController,
                              labelText: 'Password',
                              hintText: 'Password',
                              disableOrEnable: true,
                              borderColor: 0xFFBCC2C2,
                              filled: false,
                              prefixIcon: Icons.password_rounded,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  passwordVisible = !passwordVisible;
                                },
                                icon: Icon(
                                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              obscureText: !passwordVisible,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _loginPressed();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        side: BorderSide(
                                          color: Colors.white,
                                          width: 3.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}