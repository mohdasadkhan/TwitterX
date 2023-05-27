import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterx/common/common.dart';
import 'package:twitterx/constants/constants.dart';
import 'package:twitterx/features/auth/controller/auth_controller.dart';
import 'package:twitterx/features/auth/ui_view/signup_view.dart';
import 'package:twitterx/features/auth/widgets/auth_textfield.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});
  static route() => MaterialPageRoute(builder: (context) => const Login());

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    ref.read(authControllerProvider.notifier).login(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? const Loader()
          : Center(
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
                        onTap: login,
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
