import 'package:flutter/material.dart';
import 'package:taghyeer_task/presentation/screens/bottom_nav_screen/fragments/posts_fragment/posts_fragment.dart';
import 'package:taghyeer_task/presentation/screens/bottom_nav_screen/fragments/products_fragment/products_fragment.dart';
import 'package:taghyeer_task/presentation/screens/bottom_nav_screen/fragments/settings_fragment/settings_fragment.dart';

class MainBottomNavScreen extends StatelessWidget {
  MainBottomNavScreen({super.key});

  final List<Widget> _screens = [
    ProductsFragment(),
    PostsFragment(),
    SettingsFragment(),
  ];

  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _currentIndex,
        builder: (context, index, child) {
          return Scaffold(
            body: _screens[index],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: index,
              onTap: (index) {
                _currentIndex.value = index;
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Products',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.post_add),
                  label: 'Posts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        });
  }
}
