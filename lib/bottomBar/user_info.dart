import 'dart:convert';

import 'package:auksion/models/users.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../resources/colors.dart';
import '../resources/config.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _CamPageState();
}

class _CamPageState extends State<AllUsers> {

  var usersList = [];

  Future<void> _getAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    var token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('${Config().baseUrl()}/user/all'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    var data = json.decode(response.body);
    //print(response.body);
    //print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        //usersList = data;
        for (var i = 0; i < data.length; i++) {
          usersList.add(Users.fromJson(data[i]));
        }
        print('buuuusususu  ===?>> ${usersList.length}');
        print('buuuusususu  ===?>> $usersList');
      });

    } else {

    }
  }

  @override
  void initState() {
    _getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Row(
        children: [
          Text("Lion",style: TextStyle(color: MyColors.Myorange,
              fontWeight: FontWeight.bold
          ),),
          Text("Print",style: TextStyle(color: MyColors.Mywhite,
              fontWeight: FontWeight.bold
          ),),
        ],
      ),
        backgroundColor: MyColors.Myblue12,),
      body: Container(
        color: MyColors.Mymain1,
        child: Center(
          child: Text("InfoUsers"),
        ),
      ),
    );

  }
}
