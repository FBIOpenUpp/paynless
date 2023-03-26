import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsCol {
  void _saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
  }

  Future<String?> _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  void Function(String) get saveToken => _saveToken;
  Future<String?> Function() get getToken => _getToken;
}
