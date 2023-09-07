import 'package:flutter/material.dart';

import '../resource/color.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.white,
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
