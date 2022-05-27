import 'package:flutter/material.dart';
import 'package:flutter_application_todo/ui/home_page.dart';
import 'package:flutter_application_todo/ui/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'dp/dp_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DBHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        themeMode: ThemeMode.light,
        home: HomePage());
  }
}
