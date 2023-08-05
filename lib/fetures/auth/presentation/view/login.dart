import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/config/router/app_route.dart';
import 'package:room_finder_app/core/common/text/post_style_text.dart';
import 'package:room_finder_app/core/common/text/style_font_20.dart';
import 'package:room_finder_app/core/common/text/text.dart';
import 'package:room_finder_app/fetures/auth/presentation/view_model/auth_view_model.dart';

const topCenter = Alignment.topCenter;

class LogIn extends ConsumerStatefulWidget {
  const LogIn({super.key});

  @override
  ConsumerState<LogIn> createState() => _LogInState();
}

class _LogInState extends ConsumerState<LogIn> {
  final _emailController = TextEditingController(text: 'sudip@gmail.com');
  final _passwordController = TextEditingController(text: 'sudip123');
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
              Container(
                width: width * 1,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(51, 0, 255, 0.45),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
                child: const Align(
                  alignment: topCenter,
                  child: Column(
                    children: [
                      StyleText(),
                      TextStyle1(
                        text: 'Solution To The Chaos Of',
                      ),
                      TextStyle1(
                        text: 'Finding Rooms',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width * 1,
                child: Column(
                  children: [
                    const Align(
                      alignment: topCenter,
                      child: SizedBox(
                        child: TextStyle1(
                          text: 'Sign In to Continue',
                        ),
                      ),
                    ),
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: width * 0.9,
                              child: TextFormField(
                                key: const ValueKey('Email'),
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: "Enter Email Adress",
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
                                              _passwordController.text);
                                    }
                                  },
                                  child: const MakingText('Sign In')),
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
                                      const MakingText("Haven't SignIn Yet"),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, AppRoute.singUpRoute);
                                        },
                                        child: const MakingText('Sign Up'),
                                      ),
                                      const MakingText('Here')
                                    ],
                                  )
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
