import 'package:shared_preferences/shared_preferences.dart';

class Config{
  baseUrl() {
    return "https://lionprintspringboot-production.up.railway.app";
  }

  //get token shared preferences
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }
}