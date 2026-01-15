import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'core/constants/colors.dart';
import 'screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Add Firebase configuration
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bharathi Stores',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          error: AppColors.errorColor,
          surface: AppColors.whiteColor,
        ),
        scaffoldBackgroundColor: AppColors.whiteColor,
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
