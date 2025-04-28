import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:discounttour/core/providers/app_provider.dart';
import 'package:discounttour/routes/app_router.dart';
import 'package:discounttour/routes/route_names.dart';
import 'package:discounttour/features/splash/Screens/splash_screen.dart';

import 'features/home/screens/home_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // // تهيئة Firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // إنشاء Provider خارج شجرة الـ Widgets
  final appProvider = AppProvider();

  // تحميل البيانات الأولية
  await appProvider.loadData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appProvider),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discount Tour',
      debugShowCheckedModeBanner: false,
      theme: _buildAppTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.light,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RouteNames.splash,
      home: _buildAppLoader(context),
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
      primarySwatch: Colors.green,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Poppins',
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.green[800],
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  Widget _buildAppLoader(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  SplashScreen();
        }

        if (snapshot.hasError) {
          return _buildErrorScreen(snapshot.error.toString());
        }

        return  HomeScreen(); // أو HomeScreen() حسب تدفق التطبيق
      },
    );
  }

  Future<void> _initializeApp(BuildContext context) async {
    try {
      // تحميل البيانات الأولية
      await Provider.of<AppProvider>(context, listen: false).loadData();

      // أي عمليات تهيئة إضافية
      await Future.delayed(const Duration(seconds: 2)); // محاكاة تحميل البيانات
    } catch (e) {
      debugPrint('Initialization error: $e');
      throw e; // لإظهار شاشة الخطأ
    }
  }

  Widget _buildErrorScreen(String error) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 50),
            const SizedBox(height: 20),
            Text(
              'حدث خطأ في التطبيق',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => main(),
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}