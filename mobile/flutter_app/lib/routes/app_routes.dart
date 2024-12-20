import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomatin/bindings/detect_binding.dart';
import 'package:tomatin/pages/article_screen.dart';
import 'package:tomatin/bindings/register_binding.dart';
import 'package:tomatin/pages/forgotpass_screen.dart';
import 'package:tomatin/pages/main_screen.dart';
import 'package:tomatin/ui/onboarding_screen.dart';
import 'package:tomatin/pages/plantdetail_screen.dart';
import 'package:tomatin/pages/reminder_setting.dart';
import 'package:tomatin/ui/login_screen.dart';
import 'package:tomatin/ui/otp_screen.dart';
import 'package:tomatin/ui/scanresult_screen.dart';
import 'package:tomatin/ui/splash_screen.dart';
import 'package:tomatin/ui/weather_screen.dart';
import 'package:tomatin/ui/scan_screen.dart';
import '../ui/signup_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(
      name: '/signup',
      page: () => const SignUpScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(name: '/otp-register', page: () => const OtpScreen()),
    GetPage(name: '/forgotpass', page: () => const ForgotpassScreen()),
    GetPage(name: '/home', page: () => const MainScreen()),
    GetPage(
        name: '/plantdetail',
        page: () =>
            const PlantDetailScreen(plantName: 'Tomat 1', status: 'Sehat')),
    GetPage(name: '/reminder', page: () => const ReminderSetting()),
    GetPage(name: '/weather', page: () => const WeatherScreen()),
    GetPage(
      name: '/scan',
      page: () => FutureBuilder(
        future: availableCameras(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CameraDescription>? cameras = snapshot.data;
            return CameraScanScreen(
              camera: cameras!.first,
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    ),
    GetPage(
        name: '/scan-result',
        page: () => const ScanresultScreen(),
        binding: DetectBinding()),
    GetPage(
      name: '/article',
      page: () => const ArticleScreen(),
    ),
  ];
}
