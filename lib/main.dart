import 'package:cloud_music/provider/pageSettingState.dart';
import 'package:cloud_music/provider/searchBarState.dart';
import 'package:cloud_music/resource/constants.dart';
import 'package:cloud_music/util/NetworkRequest.dart';
import 'package:cloud_music/util/dependencies.dart';
import 'package:cloud_music/util/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  setupLocator();
  await getIt.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context, designSize: Size(width, height));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchBarState>(
          create: (_) => SearchBarState(),
        ),
        ChangeNotifierProvider<PageSettingState>(
          create: (_) => PageSettingState(),
        ),
      ],
      child: MaterialApp(
        title: 'Netease Cloud Music Flutter',
        debugShowCheckedModeBanner: false,
        routes: Routes.route(),
        initialRoute: Constants.homePageRoute,
        onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
        navigatorKey: GetIt.instance<GlobalKey<NavigatorState>>(),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
      ),
    );
  }
}
