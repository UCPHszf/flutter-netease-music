import 'package:flutter/material.dart';

class StyleDetail extends StatefulWidget {
  const StyleDetail({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StyleDetailState();
  }
}

class _StyleDetailState extends State<StyleDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StyleDetail"),
      ),
      body: Container(
        child: const Text("StyleDetail"),
      ),
    );
  }
}
