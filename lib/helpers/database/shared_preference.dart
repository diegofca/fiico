import 'dart:convert';
import 'package:control/helpers/manager/analytics_manager.dart';
import 'package:control/helpers/manager/firebase_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/login/view/login_page.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/repository/languages_list.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smartlook/flutter_smartlook.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Preferences get = Preferences();

  // -> Remote config variables
  int maxBudgetsFree = 0;
  int maxMovementsFree = 0;
  bool isShareBudgetFree = false;
  String? getID = '';

  void saveUser(FiicoUser? user) async {
    AnalyticsManager().setUserID(user?.id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDecode = json.encode(user?.toJson());
    await prefs.setString('user', userDecode);
  }

  Future<FiicoUser?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final string = prefs.getString('user') ?? '';
    if (string.isNotEmpty) {
      Map<String, dynamic>? valueMap = json.decode(string);
      getID = FiicoUser.fromJson(valueMap).id;
      return FiicoUser.fromJson(valueMap);
    } else {
      return null;
    }
  }

  void _deleteUser() async {
    getID = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  Future<Language> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final string = prefs.getString('lang') ?? '';
    if (string.isNotEmpty) {
      Map<String, dynamic>? valueMap = json.decode(string);

      return Language.fromJson(valueMap);
    } else {
      return Languages().items.first;
    }
  }

  void saveLang(Language lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDecode = json.encode(lang.toJson());
    await prefs.setString('lang', userDecode);
  }

  //LogOut
  void logOut(BuildContext context) async {
    _deleteUser();
    FirebaseManager.removeTopics();
    Smartlook.stopRecording();
    Smartlook.resetSession(true);
    final lang = await Preferences.get.getLang();
    FiicoRoute.send(context, LoginPage(lang: lang));
  }
}
