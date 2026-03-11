import 'package:go_router/go_router.dart';
import 'package:taghyeer_task/presentation/screens/auth_screen/login_screen.dart';
import 'package:taghyeer_task/presentation/screens/bottom_nav_screen/main_bottom_nav_screen.dart';
import 'package:taghyeer_task/presentation/screens/splash_screen/splash_screen.dart';
import 'package:taghyeer_task/presentation/screens/product_details_screen/product_details_screen.dart';
import 'package:taghyeer_task/presentation/screens/post_details_screen/post_details_screen.dart';
import 'package:taghyeer_task/domain/products_response/products_response.dart';
import 'package:taghyeer_task/domain/posts_response/posts_response.dart';

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
        routes: [
           GoRoute(
        name: productDetailsName,
        path: productDetailsPath,
        builder: (context, state) {
          final product = state.extra as Product;
          return ProductDetailsScreen(product: product);
        },
      ),
      GoRoute(
        name: postDetailsName,
        path: postDetailsPath,
        builder: (context, state) {
          final post = state.extra as Post;
          return PostDetailsScreen(post: post);
        },
      ),
        ]
      ),
    ],
  );
}

// Routes Paths
const String splashViewPath = '/';
const String loginViewPath = '/loginView';
const String mainNavViewPath = '/mainNavView';
const String productDetailsPath = 'productDetailsPath';
const String postDetailsPath = 'postDetailsPath';

// Routes Names
const String splashViewName = 'splashView';
const String loginViewName = 'loginView';
const String mainNavViewName = 'mainNavView';
const String productDetailsName = 'productDetailsView';
const String postDetailsName = 'postDetailsView';
