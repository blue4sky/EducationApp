// Class for Local Storage -> using sharedpreferences

import 'dart:convert';

import 'package:education_app/models/user_by_email.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static String userData = "data_user";

  Future<SharedPreferences> sharePref() async {
    final sharePref = await SharedPreferences.getInstance();
    return sharePref;
  }

  Future _saveString(key, data) async {
    final _pref = await sharePref();
    await _pref.setString(key, data);
  }

  Future<String?> _getString(key) async {
    final _pref = await sharePref();
    return _pref.getString(
      key,
    );
  }

  setUserData(UserData userDataModel) async {
    final json = userDataModel.toJson();
    final userDataString = jsonEncode(json);
    print("simpan");
    print(userDataString);
    await _saveString(userData, userDataString);
  }

  // Opposite of setUserData
  Future<UserData?> getUserData() async {
    final user = await _getString(userData);
    print("data from pref user");
    print(user);
    final jsonUserData = jsonDecode(user!);
    final userDataModel = UserData.fromJson(jsonUserData);
    return userDataModel;
  }
}
