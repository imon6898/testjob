import 'package:testjob/services/network/http_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/home_page/home_page.dart';
import 'pages/login_page/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    // Simulate some async operation (e.g., checking if the user is logged in)
    await Future.delayed(const Duration(seconds: 2));

    // Replace this condition with your actual authentication logic

    if (HttpRequests.isLogin) {
      Get.offAll(() => const HomePage()); // Navigate to the home page
    } else {
      Get.offAll(() => LoginPage()); // Navigate to the login page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Replace with your actual image asset path
              width: 200, // Adjust the width as needed
              height: 200, // Adjust the height as needed
            ),
            SizedBox(height: 10),
            Text(
              'Apple Gadget',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
