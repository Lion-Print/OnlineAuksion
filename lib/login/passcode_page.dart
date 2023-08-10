import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/homepage.dart';
import '../resources/colors.dart';

class PasscodeApp extends StatefulWidget {
  const PasscodeApp({super.key});

  @override
  State<PasscodeApp> createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodeApp> {
  String passcode = '';
  String name = '';
  var pass = '';
  bool isCreated = false;
  bool error = false;
  bool success = false;

  void enterDigit(int digit) {
    setState(() {
      if (passcode.length < 4) {
        passcode += digit.toString();
      }
      if (passcode.length == 4) {
        submitPasscode();
      }
    });
  }
  void pushSample() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  void deleteDigit() {
    setState(() {
      if (passcode.isNotEmpty) {
        passcode = passcode.substring(0, passcode.length - 1);
      }
    });
  }

  Future<void> submitPasscode() async {
    getPasscode().then((value) {
      if (value == 'null') {
        if (!isCreated) {
          pass = passcode;
          Timer(const Duration(seconds: 1), () {
            passcode = '';
            isCreated = true;
            setState(() {
              name = 'Parolni tasdiqlang';
            });
          });
        } else {
          if (pass == passcode) {
            createPasscode(passcode);
            setState(() {
              passcode = '';
              error = false;
              success = true;
            });
            Timer(const Duration(milliseconds: 500), () {
              pushSample();
            });
          } else {
            setState(() {
              error = true;
              passcode = '';
              name = 'Parolni tasdiqlang';
              Timer(const Duration(milliseconds: 500), () {
                setState(() {
                  passcode = '';
                  error = false;
                });
              });
            });
          }
        }
      } else {
        if (passcode == value) {
          setState(() {
            passcode = '';
            error = false;
            success = true;
          });
          Timer(const Duration(milliseconds: 500), () {
            pushSample();
          });
          //pushSample();
        } else {
          setState(() {
            error = true;
            passcode = '';
            Timer(const Duration(seconds: 1), () {
              setState(() {
                error = false;
                passcode = '';
              });
            });
          });
        }
      }
    });
  }

  //getting token from shared preferences
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    return token;
  }

  //get passcode from shared preferences
  Future<String> getPasscode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String passcode = prefs.getString('passcode').toString();
    return passcode;
  }

  //create passcode
  Future<void> createPasscode(String passcode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('passcode', passcode);
  }

  @override
  void initState() {
    super.initState();
    getPasscode().then((value) {
      if (value == 'null') {
        setState(() {
          name = 'Yangi Parolni kiriting';
        });
      } else {
        setState(() {
          name = 'Parolni kiriting';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:MyColors.colorOne,
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              "Lion",
              style: TextStyle(color: MyColors.Mywhite,
              fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Print",
              style: TextStyle(color: MyColors.Mywhite,
              fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        backgroundColor: MyColors.colorTwo,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 20.0, color: MyColors.Mywhite),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          if (error)
            Row(
              children: [
                Expanded(child: Container()),
                PasscodeView(0, enterDigit, 3),
                PasscodeView(0, enterDigit, 3),
                PasscodeView(0, enterDigit, 3),
                PasscodeView(0, enterDigit, 3),
                Expanded(child: Container()),
              ],
            ),
          if (!error&&!success)
            Row(
              children: [
                Expanded(child: Container()),
                PasscodeView(0, enterDigit, passcode.isNotEmpty ? 1 : 0),
                PasscodeView(0, enterDigit, passcode.length > 1 ? 1 : 0),
                PasscodeView(0, enterDigit, passcode.length > 2 ? 1 : 0),
                PasscodeView(0, enterDigit, passcode.length > 3 ? 1 : 0),
                Expanded(child: Container()),
              ],
            ),
          if (success)
            Row(
              children: [
                Expanded(child: Container()),
                PasscodeView(1, enterDigit, 2),
                PasscodeView(1, enterDigit, 2),
                PasscodeView(1, enterDigit, 2),
                PasscodeView(1, enterDigit, 2),
                Expanded(child: Container()),
              ],
            ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.09),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasscodeDigitButton(1, enterDigit),
              PasscodeDigitButton(2, enterDigit),
              PasscodeDigitButton(3, enterDigit),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasscodeDigitButton(4, enterDigit),
              PasscodeDigitButton(5, enterDigit),
              PasscodeDigitButton(6, enterDigit),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasscodeDigitButton(7, enterDigit),
              PasscodeDigitButton(8, enterDigit),
              PasscodeDigitButton(9, enterDigit),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FingerButton(deleteDigit),
              PasscodeDigitButton(0, enterDigit),
              PasscodeDeleteButton(deleteDigit),
            ],
          ),
        ],
      ),
    );
  }
}

class PasscodeDigitButton extends StatelessWidget {
  final int digit;
  final Function(int) onPressed;

  const PasscodeDigitButton(this.digit, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: TextButton(
        onPressed: () => onPressed(digit),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: MyColors.Mywhite,
          foregroundColor: MyColors.Myblack,
        ),
        child: Text(
          digit.toString(),
          style: const TextStyle(fontSize: 20.0, color: MyColors.Myblack),
        ),
      ),
    );
  }
}

class PasscodeDeleteButton extends StatelessWidget {
  final Function() onPressed;

  const PasscodeDeleteButton(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: MyColors.Mywhite,
          foregroundColor: Colors.blue,
        ),
        child: const Icon(Icons.backspace_outlined, color: MyColors.Myblack),
      ),
    );
  }
}

class FingerButton extends StatelessWidget {
  final Function() onPressed;

  const FingerButton(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: MyColors.Mywhite,
          foregroundColor: MyColors.colorTwo,
        ),
        child: const Icon(Icons.fingerprint, color: MyColors.Myblack),
      ),
    );
  }
}

// ignore: must_be_immutable
class PasscodeView extends StatefulWidget {
  final int digit;
  final Function(int) onPressed;
  var inputColor = 0;

  PasscodeView(this.digit, this.onPressed, this.inputColor, {super.key});

  @override
  State<PasscodeView> createState() => _PasscodeViewState();
}

class _PasscodeViewState extends State<PasscodeView> {
  @override
  Widget build(BuildContext context) {
    var color = MyColors.Myblack;
    if (widget.inputColor == 0) {
      color = Colors.black12;
    } else if (widget.inputColor == 1) {
      color = Colors.black;
    } else if (widget.inputColor == 2) {
      color = MyColors.colorTwo;
    } else if (widget.inputColor == 3) {
      color = Colors.red;
    } else {
      color = Colors.white;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.055,
        width: MediaQuery.of(context).size.width * 0.09,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: MyColors.Mywhite,
        ),
        child: Center(
          child: RestanglePassInput(color),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class RestanglePassInput extends StatelessWidget {
  var color = MyColors.colorTwo;

  RestanglePassInput(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.02,
      width: MediaQuery.of(context).size.width * 0.04,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(100), color: color),
    );
  }
}
