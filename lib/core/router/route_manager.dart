import 'package:go_router/go_router.dart';
import 'package:taghyeer_task/presentation/screens/auth_screen/login_screen.dart';
import 'package:taghyeer_task/presentation/screens/bottom_nav_screen/main_bottom_nav_screen.dart';
import 'package:taghyeer_task/presentation/screens/splash_screen/splash_screen.dart';

class RouteManager {
  static final GoRouter router = GoRouter(
    initialLocation: splashViewPath,
    routes: [
      GoRoute(
        name: splashViewName,
        path: splashViewPath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: loginViewName,
        path: loginViewPath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: mainNavViewName,
        path: mainNavViewPath,
        builder: (context, state) => MainBottomNavScreen(),
      ),
    ],
  );
}

// Routes Paths
const String splashViewPath = '/';
const String loginViewPath = '/loginView';  
const String mainNavViewPath = '/mainNavView';

// Routes Names
const String splashViewName = 'splashView';
const String loginViewName = 'loginView';
const String mainNavViewName = 'mainNavView';
