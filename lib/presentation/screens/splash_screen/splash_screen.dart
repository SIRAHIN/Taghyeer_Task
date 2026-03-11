import 'package:flutter/material.dart';
import 'package:taghyeer_task/core/cache/auth_cache_manager.dart';
import 'package:taghyeer_task/core/router/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    checkLoginState();
  }

  // Check User Login State 
  Future<void> checkLoginState ()async{
    await Future.delayed(const Duration(seconds: 1));
    String? token = await AuthCacheManager.getToken();
    if(token != null){
      RouteManager.router.go(mainNavViewPath);
    }else{
      RouteManager.router.go(loginViewPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// App Logo
            Icon(
              Icons.shopping_bag,
              size: 80,
              color: Colors.orange,
            ),

            const SizedBox(height: 20),

            /// App Name
            const Text(
              "ShopEase",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            /// Tagline
            const Text(
              "Your Daily Shopping Partner",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 40),

            /// Loading Indicator
            const CircularProgressIndicator(
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}