import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../resources/colors.dart';
import '../resources/config.dart';


class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  late TextEditingController _nameController;
  late TextEditingController _directorController;
  late TextEditingController _phoneController;
  late TextEditingController _fullNameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _directorController = TextEditingController();
    _phoneController = TextEditingController();
    _fullNameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _directorController.dispose();
    _phoneController.dispose();
    _fullNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _addCompany() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    var token = prefs.getString('token');
    final response = await http.post(Uri.parse('${Config().baseUrl()}/company'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<Object, Object>{
          "name": _nameController.text.toString(),
          "director": _directorController.text.toString(),
          "phone": _phoneController.text.toString(),
          "fullName": _fullNameController.text.toString(),
          "username": _usernameController.text.toString(),
          "password": _passwordController.text.toString(),
        }));
    if (response.statusCode == 200) {
      setState(() {
        Navigator.pop(context);
        _directorController.clear();
        _nameController.clear();
        _phoneController.clear();
        _fullNameController.clear();
        _usernameController.clear();
        _passwordController.clear();
        showToast(context, "Muvaffaqiyatli qo'shildi", MyColors.Myorange);
      });

    } else {
      setState(() {
        showToast(context, "Xatolik yuz berdi", MyColors.colorThree);
      });
    }
  }

  showToast(BuildContext context, String message,Color color) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        //backgroundColor: MyColors.Myorange,
        backgroundColor: color,
        elevation: 10,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        behavior: SnackBarBehavior.floating,
        animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation(0.5),
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.transparent,
      width: w * 0.8,
      height: h * 0.8,
      child: Dialog(
        backgroundColor: MyColors.colorOne,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
          child: ListBody(
            mainAxis: Axis.vertical,
            children: [
              SizedBox(height: h * 0.02),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add Company',
                    style:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: h * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: w * 0.8,
                      height: h * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: MyColors.colorFive),
                      child: TextField(
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: 'Name',
                          contentPadding: const EdgeInsets.only(left: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: w * 0.8,
                      height: h * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: MyColors.colorFive),
                      child: TextField(
                        controller: _directorController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: 'Director',
                          contentPadding: const EdgeInsets.only(left: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: w * 0.8,
                      height: h * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: MyColors.colorFive),
                      child: TextField(
                        controller: _phoneController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: 'Phone',
                          contentPadding: const EdgeInsets.only(left: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: w * 0.8,
                      height: h * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: MyColors.colorFive),
                      child: TextField(
                        controller: _fullNameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: 'Full Name',
                          contentPadding: const EdgeInsets.only(left: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: w * 0.8,
                      height: h * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: MyColors.colorFive),
                      child: TextField(
                        controller: _usernameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: 'Username',
                          contentPadding: const EdgeInsets.only(left: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: w * 0.8,
                      height: h * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: MyColors.colorFive),
                      child: TextField(
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: 'Password',
                          contentPadding: const EdgeInsets.only(left: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Expanded(child: SizedBox()),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: MyColors.colorFive),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_nameController.text.isEmpty ||
                              _directorController.text.isEmpty ||
                              _phoneController.text.isEmpty ||
                              _fullNameController.text.isEmpty ||
                              _usernameController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            showToast(context, 'Please fill all fields', MyColors.colorThree);
                            return;
                          }
                          _addCompany();
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(color: MyColors.colorFive),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.02),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
