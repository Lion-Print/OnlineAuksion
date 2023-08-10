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

  late TextEditingController _nameController;
  late TextEditingController _directorController;
  late TextEditingController _phoneController;
  late TextEditingController _fullNameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  var companyList = [];

  Future<void> getAllData() async {
    companyList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('${Config().baseUrl()}/company/all'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        for (var i = 0; i < data.length; i++) {
          companyList.add(Companys.fromJson(data[i]));
        }
        if (companyList.isEmpty) {
          showToast(context, 'No data', MyColors.Mymain2);
        }
        print('buuuusususu  ===?>> ${companyList.length}');
        print('buuuusususu  ===?>> $companyList');
      });
    } else {
      setState(() {
        showToast(context, 'Error', MyColors.Mymain2);
      });
    }
  }

  Future<void> _deleteCompany(id) async{
    print('id ===>> $id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.delete(
      Uri.parse('${Config().baseUrl()}/company/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      getAllData();
      setState(() {
        showToast(context, data['message'], MyColors.black);
      });
    } else {
      setState(() {
        showToast(context, data['message'], MyColors.colorThree);
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
          "userFullName": _fullNameController.text.toString(),
          "username": _usernameController.text.toString(),
          "password": _passwordController.text.toString(),
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      getAllData();
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

  @override
  void initState() {
    _nameController = TextEditingController();
    _directorController = TextEditingController();
    _phoneController = TextEditingController();
    _fullNameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    getAllData();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
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
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: MyColors.colorOne,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
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
                              //add company icon
                              Icons.account_balance,
                              color: MyColors.black,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Text(
                          'Add Company',
                          style: TextStyle(
                              color: MyColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
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
                            );   // Your custom dialog widget
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.add_circle_outline_sharp,
                        color: MyColors.white,
                      ),
                    )
                  ],
                )),
            Expanded(
              child: ListView.builder(
                itemCount: companyList.length,
                itemBuilder: (context, index) {
                  final company = companyList[index];
                  return Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: MyColors.colorOne,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
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
                                company.name.isEmpty
                                ? ''
                                    : company.name
                                    .toString()
                                    .substring(0, 1).toUpperCase(),
                                  style: const TextStyle(
                                      color: MyColors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
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
                                    company.name.toString(),
                                    style: const TextStyle(
                                        color: MyColors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  company.director.toString(),
                                  style: const TextStyle(
                                      color: MyColors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  company.phone.toString(),
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
                              icon: const Icon(
                                Icons.edit,
                                color: MyColors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _deleteCompany(company.id);
                              },
                              icon: const Icon(
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
        )
    );
  }
}