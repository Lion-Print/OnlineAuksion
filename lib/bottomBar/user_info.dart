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
    usersList.clear();
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
      print('error');
    }
  }

  Future<void> _addUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    var token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('${Config().baseUrl()}/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<Object, Object>{
        "fullName": "testov test1",
        "username": "test1",
        "password": "123",
        "roleId": 1
      }),
    );
    if (response.statusCode == 200) {
      _getAllData();
      showToast(context, 'User added',MyColors.black);
    } else {
      print('error');
      showToast(context, 'Error',MyColors.colorThree);
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
  void initState() {
    _getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text(
                "Lion",
                style: TextStyle(
                    color: MyColors.Myorange, fontWeight: FontWeight.bold),
              ),
              Text(
                "Print",
                style: TextStyle(
                    color: MyColors.Mywhite, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: MyColors.Myblue12,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: MyColors.colorOne,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: MyColors.Mymain2,
                          blurRadius: 5,
                          offset: Offset(0, 3))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: MyColors.Mymain2,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              color: MyColors.black,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Text(
                          'Add User',
                          style: TextStyle(
                              color: MyColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        _addUser();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: MyColors.white,
                      ),
                    )
                  ],
                )),
            Expanded(
              child: ListView.builder(
                itemCount: usersList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: MyColors.colorOne,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: MyColors.Mymain2,
                              blurRadius: 5,
                              offset: Offset(0, 3))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: MyColors.Mymain2,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: Text(
                                  usersList[index]
                                      .fullName
                                      .toString()
                                      .substring(0, 1),
                                  style: const TextStyle(
                                      color: MyColors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                  child: Text(
                                    usersList[index].fullName.toString(),
                                    style: const TextStyle(
                                        color: MyColors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  usersList[index].username.toString(),
                                  style: const TextStyle(
                                      color: MyColors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  usersList[index].company.name.toString(),
                                  style: const TextStyle(
                                      color: MyColors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: MyColors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: MyColors.Myorange,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
