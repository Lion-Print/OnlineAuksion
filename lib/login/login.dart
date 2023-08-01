import 'dart:convert';
import 'package:auksion/login/passcode_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/colors.dart';
import '../resources/config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late final _userController = TextEditingController();
  late final _passwordController = TextEditingController();
  void pushSample(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PasscodeApp(),
      ),
    );
  }

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('${Config().baseUrl()}/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _userController.text.toString(),
        'password': _passwordController.text.toString(),
      }),
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
      body:Center(
        child: Container(
          height: h*0.6,
          width: w*0.94,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: h*0.02,),
              SizedBox(
                height: h * 0.1,
                child: Image.asset("images/login.png"),
              ),
              SizedBox(height: h*0.01,),
              const Text(
                "Login",
                style: TextStyle(
                  color: MyColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Expanded(child: SizedBox()),
              Container(
                height: h*0.06,
                width: w*0.85,
                decoration: BoxDecoration(
                  color: MyColors.colorOne,
                  borderRadius: BorderRadius.circular(20),
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
              SizedBox(height: h*0.01,),
              Container(
                height: h*0.06,
                width: w*0.85,
                decoration: BoxDecoration(
                  color: MyColors.colorOne,
                  borderRadius: BorderRadius.circular(20),
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
                    contentPadding: EdgeInsets.only(left: 20),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Container(
                height: h*0.06,
                width: w*0.85,
                decoration: BoxDecoration(
                  color: MyColors.colorOne,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: (){
                    _login();
                    pushSample();
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
              SizedBox(height: h*0.05,),
            ],
          ),
        ),
      )
    );
  }
}
