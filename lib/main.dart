// lib/main.dart

import 'package:final_year_project2024/src/screens/help_page.dart';
import 'package:final_year_project2024/src/screens/webview_screen.dart';
import 'package:flutter/material.dart';
import 'src/utils/theme/theme.dart';
import 'src/screens/splash_screen.dart';
import 'src/screens/home_page.dart';
import 'src/screens/login_page.dart';
import 'src/screens/registration_page.dart';
import 'src/screens/forget_password_page.dart';
import 'src/screens/dashboard.dart';
import 'src/screens/profile_page.dart';
import 'src/screens/setting_page.dart';
import 'src/screens/upload_image.dart';
import 'src/screens/view_past_data.dart'; // Correct import for ViewPastData
import 'src/screens/feedback_page.dart';
import 'src/screens/start_verification_page.dart';
import 'src/screens/check_verification_page.dart';
import 'src/screens/record_screen.dart'; // Correct import for RecordScreen
import 'src/pages/bar_chart.dart'; // Correct import for BarChartPage
import 'package:final_year_project2024/api_connection/api_connection.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Project',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/dashboard': (context) => const Dashboard(),
        '/forgot_password': (context) => const ForgetPasswordPage(),
        '/profile_page': (context) =>  ProfilePage(),
        '/setting_page': (context) => SettingPage(
          onSettingsChanged: () {
          },
        ),

        '/upload_image': (context) => const UploadImage(),
        '/help': (context) =>  HelpPage(),
        '/view_past_data': (context) => const ViewPastData(),
        '/webview_screen': (context) =>  WebViewScreen(url: 'https://exagri.info/mkt/index.html'),
        '/feedback_page': (context) => const FeedbackPage(),
        '/recordsScreen': (context) =>  RecordScreen(),
        '/barChartScreen': (context) =>  BarChartPage(),
        '/startVerification': (context)  {
          final email = ModalRoute.of(context)?.settings.arguments as String;
          return StartVerificationPage(email:email);
          },
        '/checkVerification': (context) {
          final phone = ModalRoute.of(context)?.settings.arguments as String;
          final email = ModalRoute.of(context)?.settings.arguments as String;
          return CheckVerificationPage(phone: phone, email:email);
        },
      },
    );
  }
}
