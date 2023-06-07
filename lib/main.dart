import 'package:flutter/material.dart';
import 'package:vp18_api_app/prefs/shared_pref_controller.dart';
import 'package:vp18_api_app/screens/app/home_screen.dart';
import 'package:vp18_api_app/screens/app/images/images_screen.dart';
import 'package:vp18_api_app/screens/app/images/upload_image_screen.dart';
import 'package:vp18_api_app/screens/app/users_screen.dart';
import 'package:vp18_api_app/screens/auth/login_screen.dart';
import 'package:vp18_api_app/screens/auth/register_screen.dart';
import 'package:vp18_api_app/screens/core/launch_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0,
          color: Colors.white,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      initialRoute: "/launch_screen",
      routes: {
        "/launch_screen": (context) => const LaunchScreen(),
        "/users_screen": (context) => const UsersScreen(),
        "/login_screen": (context) => const LoginScreen(),
        "/register_screen": (context) => const RegisterScreen(),
        "/home_screen": (context) => const HomeScreen(),
        "/images_screen": (context) => const ImagesScreen(),
        "/upload_image_screen": (context) => const UploadImageScreen()
      },
    );
  }
}
