import 'dart:convert';
import 'dart:io';

import 'package:testjob/services/cache/cache_manager.dart';
import 'package:testjob/services/network/http_requests.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/api_routes.dart';
import '../../models/get_account_information_response_model.dart';
import '../../models/last_four_number_model.dart';
import '../../services/network/api_services.dart';
import '../login_page/login_page.dart';
import 'components/CustomTable.dart';
import 'components/CustomTextFieldsforProfile.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String? username;
  final String? token; // Add this

  const HomePage({Key? key, this.username, this.token}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController pointsController = TextEditingController();
  final TextEditingController createdAtController = TextEditingController();
  final TextEditingController updatedAtController = TextEditingController();

  final TextEditingController editFirstNameController = TextEditingController();
  final TextEditingController editLastNameController = TextEditingController();
  final TextEditingController editTitleController = TextEditingController();
  final TextEditingController editCompanyNameController = TextEditingController();
  final TextEditingController editPointsController = TextEditingController();
  final TextEditingController editCreatedAtController = TextEditingController();
  final TextEditingController editUpdatedAtController = TextEditingController();




  Future<void> GetAccount() async {
    var accountResult = await HttpRequests.get(ApiRoutes.userMe);

    if(accountResult == null) {
      return;
    }

    var accountInfo = GetAccountInformationResponse.fromJson(accountResult);

    String createdAtFormatted = accountInfo.createdAt?.toIso8601String() ?? "";
    String updatedAtFormatted = accountInfo.updatedAt?.toIso8601String() ?? "";


    //nameController.text = "";
    firstNameController.text = accountInfo.firstName ?? "";
    lastNameController.text = accountInfo.lastName ?? "";
    titleController.text = accountInfo.title ?? "";
    companyNameController.text = accountInfo.companyName ?? "";
    pointsController.text = "${accountInfo.points ?? ""}";
    createdAtController.text = createdAtFormatted;
    updatedAtController.text = updatedAtFormatted;
  }

  @override
  void initState() {
    super.initState();
    GetAccount();
    //getLastNumbersPhone();
    _imagePicker = ImagePicker();
    _image = Image.asset(
      'assets/logo.png', // Set a default image
      height: 200,
      width: 200,
      fit: BoxFit.cover,
    );
  }

  late ImagePicker _imagePicker;
  late Image _image;



  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = Image.file(
          File(pickedFile.path),
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        );
      });
    }
  }

  void _editProfileImage(BuildContext context) {
    // Add your logic for editing the profile image
    // For example, you can open an image picker or a custom edit screen
    print('Edit profile image tapped');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xff15212D),
        title: Text(
          'Welcome ${CacheManager.userName}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.red,
                child: Stack(
                  children: [
                    // Cover Photo
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'), // Add your cover photo asset
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Profile Photo
                    Positioned(
                      top: 150,
                      left: (MediaQuery.of(context).size.width - 100) / 2,
                      child: GestureDetector(
                        onTap: () => _editProfileImage(context),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset('assets/logo.png'), // Add your profile photo asset
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Change Image'),
              ),


              CustomTextFieldsforProfile(
                controller: firstNameController, // Set the controller for 'Address' field
                labelText: 'First Name',
                hintText: 'First Name',
                disableOrEnable: false,
                borderColor: 0xFFBCC2C2,
                filled: false,
                prefixIcon: Icons.code,
              ),
              CustomTextFieldsforProfile(
                controller: lastNameController,
                labelText: 'Last Name',
                hintText: 'Last Name',
                disableOrEnable: false,
                borderColor: 0xFFBCC2C2,
                filled: false,
                prefixIcon: Icons.monetization_on,
              ),
              CustomTextFieldsforProfile(
                controller: titleController,
                labelText: 'Title',
                hintText: 'Title',
                disableOrEnable: false,
                borderColor: 0xFFBCC2C2,
                filled: false,
                prefixIcon: Icons.monetization_on,
              ),
              CustomTextFieldsforProfile(
                controller: companyNameController,
                labelText: 'Company Name',
                hintText: 'Company Name',
                disableOrEnable: false,
                borderColor: 0xFFBCC2C2,
                filled: false,
                prefixIcon: Icons.monetization_on,
              ),
              CustomTextFieldsforProfile(
                controller: pointsController,
                labelText: 'Points',
                hintText: 'Points',
                disableOrEnable: false,
                borderColor: 0xFFBCC2C2,
                filled: false,
                prefixIcon: Icons.monetization_on,
              ),
              CustomTextFieldsforProfile(
                controller: createdAtController,
                labelText: 'Created Data',
                hintText: 'Created Data',
                disableOrEnable: false,
                borderColor: 0xFFBCC2C2,
                filled: false,
                prefixIcon: Icons.monetization_on,
              ),
              CustomTextFieldsforProfile(
                controller: updatedAtController,
                labelText: 'Update Data',
                hintText: 'Update Data',
                disableOrEnable: false,
                borderColor: 0xFFBCC2C2,
                filled: false,
                prefixIcon: Icons.monetization_on,
              ),

              ElevatedButton(
                onPressed: (){
                  _openBottomSheet(
                    firstNameController.text,
                    lastNameController.text,
                    titleController.text,
                    companyNameController.text,
                    pointsController.text,
                    createdAtController.text,
                    updatedAtController.text,
                  );
                },
                child: Text('Edit'),
              ),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 100,
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: GestureDetector(
                onTap: () {
                  // Call the logoutUser method from AuthService
                  logoutUser();
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 30,
                      color: Color(0xff04a2e3),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Readex Pro',
                        fontWeight: FontWeight.w400,
                        color: Color(0xff04a2e3),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _openBottomSheet(
      String firstName,
      String lastName,
      String title,
      String companyName,
      String points,
      String createdAt,
      String updatedAt,
      ) {

    editFirstNameController.text = firstName;
    editLastNameController.text = lastName;
    editTitleController.text = title;
    editCompanyNameController.text = companyName;
    editPointsController.text = points;
    editCreatedAtController.text = createdAt;
    editUpdatedAtController.text = updatedAt;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // You can build your bottom sheet content here using the passed data
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Material(
              color: Colors.black,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    CustomTextFieldsforProfile(
                      controller: editFirstNameController, // Set the controller for 'Address' field
                      labelText: 'First Name',
                      hintText: 'First Name',
                      disableOrEnable: true,
                      borderColor: 0xFFBCC2C2,
                      filled: false,
                      prefixIcon: Icons.code,
                    ),
                    CustomTextFieldsforProfile(
                      controller: editLastNameController,
                      labelText: 'Last Name',
                      hintText: 'Last Name',
                      disableOrEnable: true,
                      borderColor: 0xFFBCC2C2,
                      filled: false,
                      prefixIcon: Icons.monetization_on,
                    ),
                    CustomTextFieldsforProfile(
                      controller: editTitleController,
                      labelText: 'Title',
                      hintText: 'Title',
                      disableOrEnable: true,
                      borderColor: 0xFFBCC2C2,
                      filled: false,
                      prefixIcon: Icons.monetization_on,
                    ),
                    CustomTextFieldsforProfile(
                      controller: editCompanyNameController,
                      labelText: 'Company Name',
                      hintText: 'Company Name',
                      disableOrEnable: true,
                      borderColor: 0xFFBCC2C2,
                      filled: false,
                      prefixIcon: Icons.monetization_on,
                    ),
                    CustomTextFieldsforProfile(
                      controller: editPointsController,
                      labelText: 'Points',
                      hintText: 'Points',
                      disableOrEnable: true,
                      borderColor: 0xFFBCC2C2,
                      filled: false,
                      prefixIcon: Icons.monetization_on,
                    ),
                    CustomTextFieldsforProfile(
                      controller: editCreatedAtController,
                      labelText: 'Created Data',
                      hintText: 'Created Data',
                      disableOrEnable: true,
                      borderColor: 0xFFBCC2C2,
                      filled: false,
                      prefixIcon: Icons.monetization_on,
                    ),
                    CustomTextFieldsforProfile(
                      controller: editUpdatedAtController,
                      labelText: 'Update Data',
                      hintText: 'Update Data',
                      disableOrEnable: true,
                      borderColor: 0xFFBCC2C2,
                      filled: false,
                      prefixIcon: Icons.monetization_on,
                    ),

                    ElevatedButton(
                      onPressed: () {
                        // Validate the form
                        if (_formKey.currentState!.validate()) {
                          // Save the data
                          _saveUserData();
                          // Close the bottom sheet after saving data
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Save'),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  void _saveUserData() async {
    // Get data from controllers
    String editedFirstName = editFirstNameController.text;
    String editedLastName = editLastNameController.text;
    String editedTitle = editTitleController.text;
    String editedCompanyName = editCompanyNameController.text;
    String editedPoints = editPointsController.text;
    String editedCreatedAt = editCreatedAtController.text;
    String editedUpdatedAt = editUpdatedAtController.text;

    try {
      // Send an HTTP request to update user data using HttpRequests.putJson
      final result = await HttpRequests.putJson(ApiRoutes.userMe, body: {
        'first_name': editedFirstName,
        'last_name': editedLastName,
        'title': editedTitle,
        'company_name': editedCompanyName,
        'points': int.parse(editedPoints), // Assuming points is an integer
        'created_at': editedCreatedAt,
        'updated_at': editedUpdatedAt,
      });

      // Check if the result is not null before accessing properties
      if (result != null) {
        if (result.statusCode == 200) {
          print('User data updated successfully');
        } else {
          print('Failed to update user data: ${result.reasonPhrase}');
        }
      } else {
        print('Failed to update user data: Null response');
      }
    } catch (error) {
      print('Error updating user data: $error');
    }
  }


  void logoutUser() {
    // Clear the token in SharedPreferences
    // authService.clearToken();
    HttpRequests.logout();
    // Navigate to the login page
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
  }



}