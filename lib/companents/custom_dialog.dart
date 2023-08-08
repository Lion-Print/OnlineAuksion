import 'package:flutter/material.dart';

import '../resources/colors.dart';

class CustomDialog extends StatelessWidget {
  late TextEditingController _nameController;
  late TextEditingController _directorController;
  late TextEditingController _phoneController;
  late TextEditingController _fullNameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // Adjust dialog properties like shape, elevation, etc.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }


  Widget _buildDialogContent(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    _nameController = TextEditingController();
    _directorController = TextEditingController();
    _phoneController = TextEditingController();
    _fullNameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    return Container(
      width: w * 0.8,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add Company',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: h * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: w * 0.8,
              height: h * 0.06,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: MyColors.Mymain2),
              child: TextField(
                controller: _nameController,
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
                  color: MyColors.Mymain2),
              child: TextField(
                controller: _directorController,
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
                  color: MyColors.Mymain2),
              child: TextField(
                controller: _phoneController,
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
          SizedBox(height: h * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: w * 0.8,
              height: h * 0.06,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: MyColors.Mymain2),
              child: TextField(
                controller: _fullNameController,
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
                  color: MyColors.Mymain2),
              child: TextField(
                controller: _usernameController,
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
                  color: MyColors.Mymain2),
              child: TextField(
                controller: _passwordController,
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
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
