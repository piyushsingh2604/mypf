import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypf/firebase_options.dart';
import 'package:mypf/home_view.dart';
import 'package:mypf/mobile_home_view.dart';
import 'package:mypf/utils/web_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: WebTheme.lightTheme,
      darkTheme: WebTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends GetResponsiveView {
  DashboardPage({Key? key}) : super(key: key);

  @override
  Widget phone() {
    return MobileHomeView();
  }

  @override
  Widget tablet() {
    return HomeView();
  }

  @override
  Widget desktop() {
    return HomeView();
  }
}
