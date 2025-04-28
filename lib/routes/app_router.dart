import 'package:flutter/material.dart';
import 'package:discounttour/features/home/screens/home_screen.dart';
import 'package:discounttour/features/tour_details/screens/details_screen.dart';
import 'package:discounttour/features/splash/screens/splash_screen.dart';
import 'package:discounttour/features/auth/screens/login_screen.dart';
import 'package:discounttour/features/auth/screens/register_screen.dart';
import 'package:discounttour/features/profile/screens/profile_screen.dart';
import 'package:discounttour/features/booking/screens/booking_screen.dart';
import 'package:discounttour/features/home/models/tour_model.dart';
import 'package:discounttour/routes/route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return _fadeRoute(const SplashScreen(), settings);

      case RouteNames.home:
        return _fadeRoute( HomeScreen(), settings);

      case RouteNames.login:
        return _slideRoute(const LoginScreen(), settings);

      case RouteNames.register:
        return _slideRoute(const RegisterScreen(), settings);

      case RouteNames.profile:
        return _fadeRoute(const ProfileScreen(), settings);

      case RouteNames.booking:
        final tour = settings.arguments as TourModel?;
        if (tour != null) {
          return _fadeRoute(BookingScreen(tour: tour), settings);
        }
        return _errorRoute('Tour data is required', settings);

      case RouteNames.tourDetails:
        final tour = settings.arguments as TourModel?;
        if (tour != null) {
          return _fadeRoute(TourDetailsScreen(tour: tour), settings);
        }
        return _errorRoute('Tour data is required', settings);

      default:
        return _errorRoute('Page not found: ${settings.name}', settings);
    }
  }

  // انتقال تدريجي (لشاشات التحميل والرئيسية)
  static PageRouteBuilder _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // انتقال انزلاقي (لشاشات الدخول والتسجيل)
  static PageRouteBuilder _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      fullscreenDialog: true,
    );
  }

  // صفحة الخطأ
  static MaterialPageRoute _errorRoute(String message, RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 50, color: Colors.red),
              const SizedBox(height: 20),
              Text(
                message,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة مساعدة للانتقال الآمن
  static Future<T?> navigateTo<T extends Object?>(
      BuildContext context,
      String routeName, {
        Object? arguments,
        bool replace = false,
        bool clearStack = false,
      }) {
    if (clearStack) {
      return Navigator.of(context).pushNamedAndRemoveUntil(
        routeName,
            (route) => false,
        arguments: arguments,
      );
    } else if (replace) {
      return Navigator.of(context).pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    } else {
      return Navigator.of(context).pushNamed(
        routeName,
        arguments: arguments,
      );
    }
  }

  // التحقق من البيانات قبل الانتقال
  static void validateAndNavigate(
      BuildContext context,
      String routeName, {
        required Object? arguments,
        required bool Function(Object?) validator,
        String? errorMessage,
      }) {
    if (validator(arguments)) {
      navigateTo(context, routeName, arguments: arguments);
    } else {
      _showErrorDialog(context, errorMessage ?? 'Invalid data for navigation');
    }
  }

  static void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}