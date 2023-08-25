import 'dart:async';
import 'dart:convert';
import 'package:cloud_music/page/home.dart';
import 'package:cloud_music/resource/color.dart';
import 'package:cloud_music/resource/constants.dart';
import 'package:cloud_music/resource/dim.dart';
import 'package:cloud_music/util/dependencies.dart';
import 'package:cloud_music/util/NetworkRequest.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../provider/pageSettingState.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? urlQRCode;
  String Tag = 'SignInPage';
  Logger logger = getIt<Logger>();
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void startTimerOnCheckQRCodeStatus(String qrCodeKey,
      {required int second, required int interval}) {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: interval), (timer) async {
      if (second > 0) {
        second -= interval;
        final qrStatusCode = await NetworkRequest.checkQRCodeStatus(qrCodeKey);
        if (qrStatusCode == Constants.qrAuthorizeSuccess) {
          timer.cancel();
          if (context.mounted) {
            Navigator.pushNamed(context, Constants.homePageRoute);
          }
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double signInPageTopContainerHeight = 300;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(Constants.signInPageAppBarTitle),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            bottom: Dim.screenUtilOnVertical(Dim.signInPageBottomPadding)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: Dim.screenUtilOnVertical(signInPageTopContainerHeight),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.signInPageTopContainerGradientStart,
                    AppColor.signInPageTopContainerGradientEnd,
                  ],
                ),
              ),
            ),
            Center(
              child: SizedBox(
                  width: Dim.qrCodeSize,
                  height: Dim.qrCodeSize,
                  child: urlQRCode == null
                      ? null
                      : Image.memory(base64Decode(urlQRCode!))),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  String qrCodeKey = await NetworkRequest.generateQRCodeKey();
                  String qrCodeBase64 =
                      await NetworkRequest.generateQRCode(qrCodeKey);
                  qrCodeBase64 = qrCodeBase64
                      .split(",")
                      .last
                      .replaceAll(RegExp(r'\s+'), '');
                  //add a timer for 10 second, every two second send a request to access the qrcode status
                  setState(() {
                    urlQRCode = qrCodeBase64;
                  });
                  startTimerOnCheckQRCodeStatus(qrCodeKey,
                      second: 20,
                      interval: Constants.requestQRCodeStatusInterval);
                },
                child: const Text(Constants.generateQRCode),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
