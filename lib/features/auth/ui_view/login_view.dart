import 'package:flutter/material.dart';
import 'package:twitterx/constants/constants.dart';
import 'package:twitterx/features/auth/ui_view/signup_view.dart';
import 'package:twitterx/features/auth/widgets/auth_textfield.dart';

import '../../../common/common.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static route() => MaterialPageRoute(builder: (context) => const Login());

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AuthField(
                  controller: emailController,
                  hint: 'Email',
                ),
                const SizedBox(
                  height: 30.0,
                ),
                AuthField(
                  controller: passwordController,
                  hint: 'Password',
                ),
                const SizedBox(
                  height: 30.0,
                ),
                RoundButton(
                  onTap: () {},
                  label: 'Done',
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    TextButton(
                        onPressed: () =>
                            Navigator.push(context, SignUp.route()),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 20.0),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
