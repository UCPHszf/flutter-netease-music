import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_music/util/dependencies.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../resource/constants.dart';

class NetworkManager {
  static NetworkManager? _instance;
  late Dio _dio;

  NetworkManager._() {
    _dio = Dio(); // Initialize Dio instance
  }

  factory NetworkManager.getInstance() {
    _instance ??= NetworkManager._();
    return _instance!;
  }

  Dio get dio => _dio;

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
          .collection(Constants.firebaseSettingCollection)
          .doc(Constants.apiDocument);
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
