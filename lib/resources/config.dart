import 'package:shared_preferences/shared_preferences.dart';

class Config{
  baseUrl() {
    return "http://192.168.0.25:8008";
  }

  //get token shared preferences
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }
}