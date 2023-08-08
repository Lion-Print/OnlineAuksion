import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/company.dart';
import '../resources/colors.dart';
import '../resources/config.dart';
class Company extends StatefulWidget {
  const Company({super.key});

  @override
  State<Company> createState() => _CamPageState();
}

class _CamPageState extends State<Company> {

  var companyList = [];

  Future<void> _getAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    var token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('${Config().baseUrl()}/company/all'),
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
          companyList.add(Companys.fromJson(data[i]));
        }
        print('buuuusususu  ===?>> ${companyList.length}');
        print('buuuusususu  ===?>> $companyList');
      });
    } else {
      print('error');
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: companyList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(companyList[index].name.toString(),style: TextStyle(color: MyColors.black,
                        fontWeight: FontWeight.bold
                    ),),
                    subtitle: Text(companyList[index].phone.toString(),style: TextStyle(color: MyColors.black,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                );
              },
            ),
          ),
        ],
      )
    );

  }
}
