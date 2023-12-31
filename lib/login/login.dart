import 'dart:convert';
import 'package:auksion/login/passcode_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../resources/colors.dart';
import '../resources/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late final _userController = TextEditingController();
  late final _passwordController = TextEditingController();

  void pushSample() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PasscodeApp(),
      ),
    );
  }

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('${Config().baseUrl()}/login'),
      body: {
        'username': _userController.text.toString(),
        'password': _passwordController.text.toString(),
      },
    );
    //print(response.body);
    /*
    * {
    "accessToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIrMTAwIiwicm9sZXMiOlsiUk9MRV9BRE1JTiJdLCJpc3MiOiJodHRwOi8vbGlvbnByaW50c3ByaW5nYm9vdC1wcm9kdWN0aW9uLnVwLnJhaWx3YXkuYXBwL2FwaS92MS9sb2dpbiIsImV4cCI6MTY5MjI1ODc2Nn0.gHs0gjgrRek9a4AWUMgtW-y2GzRlSo-dkQDbyfQSGLg",
    "user": {
        "createdBy": null,
        "createdDate": 1691382282057,
        "modifiedBy": null,
        "modifiedDate": 1691382282057,
        "id": 1,
        "fullName": "Aliyev valijon",
        "username": "+100",
        "password": "$2a$10$gL2KnimmK8JADulWoH9M6emHYZNmaKzceFzOPOfJT2aE/AXLVWcXi",
        "fcmToken": null,
        "role": {
            "id": 1,
            "name": "ROLE_ADMIN"
        },
        "company": null,
        "supplier": null
    },
    "refreshToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIrMTAwIiwicm9sZXMiOlsiUk9MRV9BRE1JTiJdLCJpc3MiOiJodHRwOi8vbGlvbnByaW50c3ByaW5nYm9vdC1wcm9kdWN0aW9uLnVwLnJhaWx3YXkuYXBwL2FwaS92MS9sb2dpbiIsImV4cCI6MTY5Mzk4Njc2Nn0.b8QJOQqkCidzxnq3BwlO_71V6zfyPoXHXPSEq2WYYLI"
}*/
    var data = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data['accessToken']);
      prefs.setString('refreshToken', data['refreshToken']);
      prefs.setString('user', json.encode(data['user']));
      pushSample();

    } else {
      _showErrorDialog(data['message']);
    }
  }
  //show alert dialog with error message
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.colorOne,
      body: Center(
        child: Container(
          height: h * 0.6,
          width: w * 0.94,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: h * 0.02,
              ),
              SizedBox(
                height: h * 0.1,
                child: Image.asset("images/login.png"),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              const Text(
                "Login",
                style: TextStyle(
                  color: MyColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Container(
                height: h * 0.06,
                width: w * 0.85,
                decoration: BoxDecoration(
                  color: MyColors.colorOne,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _userController,
                  cursorColor: MyColors.white,
                  style: const TextStyle(
                    color: MyColors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Login",
                    fillColor: MyColors.white,
                    hintStyle: TextStyle(
                      color: MyColors.white,
                      decorationColor: MyColors.white,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 20),
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Container(
                height: h * 0.06,
                width: w * 0.85,
                decoration: BoxDecoration(
                  color: MyColors.colorOne,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _passwordController,
                  style: const TextStyle(
                    color: MyColors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: MyColors.white,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Container(
                height: h * 0.06,
                width: w * 0.85,
                decoration: BoxDecoration(
                  color: MyColors.colorOne,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    _login();
                    //pushSample();
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: MyColors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
