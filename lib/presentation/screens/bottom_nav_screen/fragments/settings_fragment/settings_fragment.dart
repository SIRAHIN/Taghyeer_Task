import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_task/presentation/bloc/settings_cubit/cubit/settings_cubit.dart';
import 'package:taghyeer_task/presentation/bloc/theme_cubit/cubit/theme_cubit.dart';

class SettingsFragment extends StatefulWidget {
  const SettingsFragment({super.key});

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (userInfo) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: userInfo.image != null
                          ? NetworkImage(userInfo.image!)
                          : null,
                      child: userInfo.image == null
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.grey)
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${userInfo.firstName ?? ''} ${userInfo.lastName ?? ''}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '@${userInfo.username ?? ''}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 32),
                    BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, themeState) {
                        final isDark = themeState.maybeWhen(
                          darkMode: () => true,
                          orElse: () => false,
                        );

                        return SwitchListTile(
                          title: const Text('Dark Mode'),
                          secondary: Icon(
                            isDark ? Icons.dark_mode : Icons.light_mode,
                            color: Colors.red,
                          ),
                          value: isDark,
                          onChanged: (value) {
                            context.read<ThemeCubit>().toggleTheme();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey.shade200)),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      leading:
                          const Icon(Icons.email_outlined, color: Colors.red),
                      title: const Text('Email'),
                      subtitle: Text(userInfo.email ?? 'N/A'),
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade200)),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      leading:
                          const Icon(Icons.person_outline, color: Colors.red),
                      title: const Text('Gender'),
                      subtitle: Text(userInfo.gender ?? 'N/A'),
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade200)),
                    ),
                  ],
                ),
              );
            },
            error: (errorResponse) => Center(
              child: Text(errorResponse.message ?? 'An error occurred'),
            ),
          );
        },
      ),
    );
  }
}
