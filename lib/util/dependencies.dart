import 'package:cloud_music/util/networkManager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<GlobalKey<NavigatorState>>(
      GlobalKey<NavigatorState>());
  getIt.registerSingletonAsync<NetworkManager>(() async {
    final instance = NetworkManager.getInstance();
    await instance.initialize();
    return instance;
  });
  getIt.registerSingleton<Logger>(Logger());
}
