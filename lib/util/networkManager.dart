import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_music/util/dependencies.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../resource/constants.dart';

class NetworkManager {
  static NetworkManager? _instance;
  late Dio _dio;
  late String _cookie;
  late CookieJar _cookieJar;

  NetworkManager._() {
    _dio = Dio(); // Initialize Dio instance
    _cookie = "";
    _cookieJar = CookieJar();
  }

  factory NetworkManager.getInstance() {
    _instance ??= NetworkManager._();
    return _instance!;
  }

  CookieJar get cookieJar => _cookieJar;

  Dio get dio => _dio;

  Future<void> prepareJar() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final jar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage("$appDocPath/.cookies/"),
    );
    dio.interceptors.add(CookieManager(jar));
  }

  Future<void> initialize() async {
    String baseUrl = await _getApiServer();
    if (baseUrl.isEmpty) throw Exception('apiServer is empty');
    _dio.options.baseUrl = baseUrl;
    print(baseUrl);
    _dio.options.connectTimeout =
        const Duration(seconds: Constants.connectTimeoutSeconds);
    _dio.options.receiveTimeout =
        const Duration(seconds: Constants.receiveTimeoutSeconds);
    _dio.interceptors.clear();
    _dio.interceptors.add(CookieManager(cookieJar));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          handler.reject(e);
          GlobalKey<NavigatorState> navigatorKey =
              getIt<GlobalKey<NavigatorState>>();
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
              Constants.signInPageRoute, (route) => false);
          return;
        }
        return handler.next(e); //continue
      },
    ));
  }

  Future<String> _getApiServer() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      final DocumentReference apiDocument = firestore
          .collection(Constants.firebaseCollection)
          .doc(Constants.settingDoc);
      DocumentSnapshot snapshot = await apiDocument.get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return data[Constants.apiServerField] as String;
      } else {
        throw Exception('apiServer not found');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return "";
    }
  }
}
