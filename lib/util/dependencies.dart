import 'package:cloud_music/util/networkManager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<GlobalKey<NavigatorState>>(
      GlobalKey<NavigatorState>());
  getIt.registerSingletonAsync<NetworkManager>(() async {
    final instance = NetworkManager.getInstance();
    await instance.initialize();
    return instance;
  });
  getIt.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  getIt.registerSingleton<Logger>(Logger());
}
