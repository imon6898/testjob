import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../config/api_routes.dart';
import '../cache/cache_manager.dart';

class HttpRequests {

  static bool isLogin = false;
  static String _token = "", userName = '';
  static String _loginEmail = '';


  static void logout() {
    CacheManager.removeToken();
    CacheManager.removeUserName();
    CacheManager.removeLoginUserName();
    _token = CacheManager.token;
    userName = CacheManager.userName;
    _loginEmail = CacheManager.loginEmail;
    isLogin = _token.isEmpty ? false : true ;
  }

  static Future init() async {
    await CacheManager.initAuth((p) {
      _token = CacheManager.token;
      userName = CacheManager.userName;
      _loginEmail = CacheManager.loginEmail;
      isLogin = _token.isEmpty ? false : true ;
    });

    print("the token: $_token");
  }

  static String setToken(String token) {
    CacheManager.setToken(token);
    isLogin = token.isEmpty ? false : true ;
    _token = token;
    return _token;
  }

  static String setLoginEmail(String loginEmail) {
    CacheManager.setLoginEmail(loginEmail);
    _loginEmail = loginEmail;
    return _loginEmail;
  }

  static Future post(String path, {body}) async {
    Uri uri = Uri.parse("${ApiRoutes.prefix}$path");
    var request = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: body
    );

    print("$path-> ${request.body}");

    if(request.statusCode == 400) {
      return jsonDecode(request.body);
    }

    if(request.statusCode != 200) {
      return;
    }

    return jsonDecode(request.body);
  }

  static Future postJson(String path, {Map<String, dynamic>? body, isLoginTime = false}) async {
    Uri uri = Uri.parse("${ApiRoutes.prefix}$path");

    Map<String, dynamic> payload = body ?? {};

    if(!isLoginTime){

      print("no login time ");

      payload['login'] = _loginEmail;
      payload['token'] = _token;
    }
    print("nolgintime payload: $payload");
    var request = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          // 'Accept': '*/*',
          // 'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(payload)
    );

    print("${"${ApiRoutes.prefix}$path"}-> ${request.body}");

    if(request.statusCode == 400) {
      return jsonDecode(request.body);
    }

    if(request.statusCode != 200) {
      return;
    }

    return jsonDecode(request.body);
  }

  static Future putJson(String path, {Map<String, dynamic>? body, isLoginTime = false}) async {
    Uri uri = Uri.parse("${ApiRoutes.prefix}$path");

    Map<String, dynamic> payload = body ?? {};

    if(!isLoginTime){

      print("no login time ");

      payload['login'] = _loginEmail;
      payload['token'] = _token;
    }
    print("nolgintime payload: $payload");
    var request = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          // 'Accept': '*/*',
          // 'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(payload)
    );

    print("${"${ApiRoutes.prefix}$path"}-> ${request.body}");

    if(request.statusCode == 400) {
      return jsonDecode(request.body);
    }

    if(request.statusCode != 200) {
      return;
    }

    return jsonDecode(request.body);
  }

  static Future get(String path) async {
    Uri uri = Uri.parse("${ApiRoutes.prefix}$path");
    var request = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    print("uri: $uri Res: ${request.body}");

    if(request.statusCode != 200) {
      return;
    }

    return jsonDecode(request.body);
  }


  static Future put(String path, {required Map<String, dynamic> body}) async {
    Uri uri = Uri.parse("${ApiRoutes.prefix}$path");

    var request = await http.put(
      uri,
      headers: {
        //'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json', // Add this line to specify JSON content type
      },
      body: jsonEncode(body), // Encode the request body as JSON
    );

    print("uri: $uri Res: ${request.body}");

    if (request.statusCode != 200) {
      // Handle the case when the request was not successful
      return null;
    }

    // Parse and return the JSON response
    return jsonDecode(request.body);
  }





  static Future multipartPostRequest(String path, {File? file, required Map<String, String> body}) async {
    try {
      Uri uri = Uri.parse("${ApiRoutes.prefix}$path");
      var request = http.MultipartRequest('POST', uri)
        ..headers['Accept'] = "application/json"
        ..headers['Authorization'] = "Bearer $_token";

      request.fields.addAll(body);

      print("payloads: ${request.fields}");

      if(file != null){
        request.files.add(
            http.MultipartFile.fromBytes(
                "image",
                file.readAsBytesSync(),
                filename: file.path.split("/").last)
        );
      }
      var response = (await http.Response.fromStream(await request.send()));
      print("multipartPostRequest: ${response.body}");
      if(response.statusCode != 200) {
        return;
      }

      return jsonDecode(response.body);
    } catch (e) {
      print('error due to post leave');
      return;
    }
  }

  static Future filesMultipartPostRequest(String path, { Map<String, File> files = const {}, required Map<String, String> body}) async {
    try {
      Uri uri = Uri.parse("${ApiRoutes.prefix}$path");
      var request = http.MultipartRequest('POST', uri)
        ..headers['Accept'] = "application/json"
        ..headers['Authorization'] = "Bearer $_token";

      request.fields.addAll(body);

      print("payloads: ${request.fields}");

      if(files.isNotEmpty){
        files.forEach((key, file) {
          request.files.add(
              http.MultipartFile.fromBytes(
                  key,
                  file.readAsBytesSync(),
                  filename: file.path.split("/").last)
          );
        });
      }
      var response = (await http.Response.fromStream(await request.send()));
      print("$path --> ${response.body}");
      if(response.statusCode != 200) {
        return;
      }

      return jsonDecode(response.body);
    } catch (e) {
      print('error due to post leave');
      return;
    }
  }


}