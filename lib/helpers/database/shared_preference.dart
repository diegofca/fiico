import 'dart:convert';

import 'package:control/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Preferences get = Preferences();

  void saveUser(FiicoUser? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDecode = json.encode(user?.toJson());
    await prefs.setString('user', userDecode);
  }

  Future<FiicoUser?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final string = prefs.getString('user') ?? '';
    if (string.isNotEmpty) {
      Map<String, dynamic>? valueMap = json.decode(string);
      return FiicoUser.fromJson(valueMap);
    } else {
      return null;
    }
  }
}
