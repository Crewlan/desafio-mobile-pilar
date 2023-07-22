import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class IToggleConfig {
  String getString(String key);

  int getInt(String key);

  bool getBool(String key);

  List<T> getList<T>(String key);
}

class ToggleConfig implements IToggleConfig {
  final FirebaseRemoteConfig firebaseRemoteConfig;

  ToggleConfig(this.firebaseRemoteConfig);

  @override
  bool getBool(String key) {
    return firebaseRemoteConfig.getBool(key);
  }

  @override
  int getInt(String key) {
    return firebaseRemoteConfig.getInt(key);
  }

  @override
  List<T> getList<T>(String key) {
    try {
      final remoteConfigValue = firebaseRemoteConfig.getValue(key);
      var listDynamic = jsonDecode(remoteConfigValue.asString());
      return List<T>.from(listDynamic);
    } catch (e) {
      return [];
    }
  }

  @override
  String getString(String key) {
    return firebaseRemoteConfig.getString(key);
  }
}
