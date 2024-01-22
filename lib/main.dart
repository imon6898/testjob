import 'package:testjob/pages/login_page/login_page.dart';
import 'package:testjob/services/network/http_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package
import 'services/network/api_services.dart';
import 'splash_screen.dart'; // Import your splash screen file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpRequests.init();
  runApp(const MyApp());
  // Initialize and put UserController
  Get.put(UserController());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Wrap MaterialApp with GetMaterialApp
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
