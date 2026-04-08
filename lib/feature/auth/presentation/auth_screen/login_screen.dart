import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_task/core/router/route_manager.dart';
import 'package:taghyeer_task/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        userNameController.text,
        passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.success) {
              // success toast 
              toastification.show(
                context: context,
                title: Text("Login Success"),
                type: ToastificationType.success,
                autoCloseDuration: const Duration(seconds: 2),
              );
              // Navigate to home screen
              RouteManager.router.go(mainNavViewPath);
            } else if (state.status == AuthStatus.error) {
              // error toast 
              toastification.show(
                context: context,
                title: Text(state.errorMessage ?? "Login Failed"),
                type: ToastificationType.error,
                autoCloseDuration: const Duration(seconds: 2),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
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
              "Shoppy",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

                  // Email
                  TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                      labelText: "User Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter user name";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Password
                  TextFormField(
                    controller: passwordController,
                    obscureText: state.isShowPassword,
                    decoration:  InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(state.isShowPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          context.read<AuthCubit>().togglePasswordVisibility();
                        },
                      ),
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: login,
                      child: state.status == AuthStatus.loading
                          ? const CircularProgressIndicator()
                          : const Text("Login"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
