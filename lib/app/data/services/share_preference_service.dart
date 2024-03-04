import 'dart:convert';

import 'package:flutter_printer/app/utils/extension/app_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class SharedPrefferenceService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void saveUserModel(UserModel userModel) async {
    SharedPreferences pref = await _prefs;
    print('data save tojson ${userModel.toJson()}');
    pref.setString('userModel', jsonEncode(userModel));
    logSys('sharepreference : save userModel');
  }

  Future<String?> getUserModel() async {
    SharedPreferences pref = await _prefs;
    return pref.getString('userModel');
  }

  Future<void> saveToken(String token) async {
    SharedPreferences pref = await _prefs;
    pref.setString('token', token);
    logSys('sharepreference : save token $token');
  }

  Future<String?> getToken() async {
    SharedPreferences pref = await _prefs;
    return pref.getString('token');
  }

  Future<void> saveUrl(String url) async {
    SharedPreferences pref = await _prefs;
    pref.setString('url', url);
    logSys('sharepreference : save url $url');
  }

  Future<String?> getUrl() async {
    SharedPreferences pref = await _prefs;
    return pref.getString('url');
  }

  Future<void> saveTokenPubSub(String tokenPubSub) async {
    SharedPreferences pref = await _prefs;
    pref.setString('token_pub_sub', tokenPubSub);
    logSys('sharepreference : save token $tokenPubSub');
  }

  Future<String?> getTokenPubSub() async {
    SharedPreferences pref = await _prefs;
    return pref.getString('token_pub_sub');
  }

  void clear() async {
    SharedPreferences pref = await _prefs;

    pref.clear();
  }
}
