import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taghyeer_task/core/router/route_manager.dart';
import 'package:taghyeer_task/injection.dart';
import 'package:taghyeer_task/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:taghyeer_task/presentation/bloc/products_cubit/cubit/products_cubit.dart';
import 'package:taghyeer_task/presentation/bloc/posts_cubit/cubit/posts_cubit.dart';
import 'package:taghyeer_task/presentation/bloc/settings_cubit/cubit/settings_cubit.dart';
import 'package:taghyeer_task/presentation/bloc/theme_cubit/cubit/theme_cubit.dart';
import 'package:taghyeer_task/presentation/bloc/internet_status_cubit/cubit/internet_status_cubit.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ProductsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<PostsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<SettingsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ThemeCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<InternetStatusCubit>(),
        ),
      ],
      child: ToastificationWrapper(
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                final isDarkMode = themeState.maybeWhen(
                  darkMode: () => true,
                  orElse: () => false,
                );

                return MaterialApp.router(
                  theme: ThemeData(
                    useMaterial3: true,
                    brightness: Brightness.light,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.red,
                      primary: Colors.red,
                      secondary: Colors.black,
                      brightness: Brightness.light,
                    ),
                  ),
                  darkTheme: ThemeData(
                    useMaterial3: true,
                    brightness: Brightness.dark,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.red,
                      primary: Colors.red,
                      secondary: Colors.white,
                      brightness: Brightness.dark,
                    ),
                  ),
                  themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
                  debugShowCheckedModeBanner: false,
                  routerConfig: RouteManager.router,
                  builder: (context, child) {
                    return BlocListener<InternetStatusCubit,
                        InternetStatusState>(
                      listener: (context, internetState) {
                        internetState.when(
                          initial: () {},
                          connected: () async {
                           toastification.dismissAll();
                           await context.read<ProductsCubit>().getAllProducts();
                           await context.read<PostsCubit>().getAllPosts();
                          },
                          disconnected: () {
                            toastification.dismissAll();
                            toastification.show(
                              context: context,
                              type: ToastificationType.error,
                              style: ToastificationStyle.flatColored,
                              title: const Text('No Internet Connection'),
                              description: const Text(
                                  'Please check your network settings.'),
                              autoCloseDuration: null,
                              closeButtonShowType: CloseButtonShowType.none,
                              dragToClose: false,
                            );
                          },
                        );
                      },
                      child: child!,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
