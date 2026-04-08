import 'package:flutter/material.dart';
import 'package:taghyeer_task/presentation/screens/bottom_nav_screen/fragments/posts_fragment/posts_fragment.dart';
import 'package:taghyeer_task/presentation/screens/bottom_nav_screen/fragments/products_fragment/products_fragment.dart';
import 'package:taghyeer_task/feature/settings/presentation/settings_fragment/settings_fragment.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {

  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  final List<Widget> _screens = const [
    ProductsFragment(),
    PostsFragment(),
    SettingsFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, currentIndex, child) {
        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: _screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              _currentIndex.value = index;
            },
            items: const [
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
      },
    );
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }
}