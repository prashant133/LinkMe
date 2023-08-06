import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/config/router/app_route.dart';
import 'package:room_finder_app/core/common/text/text.dart';
import 'package:room_finder_app/fetures/auth/presentation/view_model/auth_view_model.dart';

const topCenter = Alignment.topCenter;

class LogIn extends ConsumerStatefulWidget {
  const LogIn({super.key});

  @override
  ConsumerState<LogIn> createState() => _LogInState();
}

class _LogInState extends ConsumerState<LogIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/splash.png', // Replace with the actual image asset path
                width: width, // Set the width as needed
              ),
              SizedBox(
                width: width * 1,
                child: Column(
                  children: [
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          SizedBox(
                            width: width * 0.9,
                            child: TextFormField(
                              key: const ValueKey('Email'),
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: "Enter Email Address",
                                prefixIcon: const Icon(
                                  Icons.person,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: width * 0.9,
                            child: TextFormField(
                              key: const ValueKey('Password'),
                              obscureText: isObscure,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter Password',
                                prefixIcon: const Icon(
                                  Icons.lock,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Password';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: width * 0.5,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_key.currentState!.validate()) {
                                    await ref
                                        .read(authViewModelProvider.notifier)
                                        .loginUser(
                                          context,
                                          _emailController.text,
                                          _passwordController.text,
                                        );
                                  }
                                },
                                child: const MakingText('Sign In'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: width * 1,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const MakingText("Haven't Signed Up Yet"),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            AppRoute.singUpRoute,
                                          );
                                        },
                                        child: const MakingText('Sign Up'),
                                      ),
                                      const MakingText('Here')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
