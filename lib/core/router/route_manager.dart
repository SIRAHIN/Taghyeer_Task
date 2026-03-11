import 'package:go_router/go_router.dart';
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
        name: mainNavViewName,
        path: mainNavViewPath,
        builder: (context, state) =>  MainBottomNavScreen(),
      ),
    ],
  );
}

// Routes Paths 
const String splashViewPath = '/';
const String mainNavViewPath = '/mainNavView';

// Routes Names 
const String splashViewName = 'splashView';
const String mainNavViewName = 'mainNavView';