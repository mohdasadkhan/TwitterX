import 'package:flutter/material.dart';
import 'package:twitterx/common/common.dart';
import 'package:twitterx/constants/constants.dart';
import 'package:twitterx/features/auth/ui_view/login_view.dart';
import 'package:twitterx/features/auth/widgets/auth_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static route() => MaterialPageRoute(builder: (context) => const Login());

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                      'Already have an account?',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(context, Login.route()),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    )
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
