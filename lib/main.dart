import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterx/common/common.dart';
import 'package:twitterx/features/auth/controller/auth_controller.dart';
import 'package:twitterx/features/auth/ui_view/signup_view.dart';
import 'package:twitterx/features/home/screens/home_screen.dart';

import 'theme/theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twitter X',
        theme: AppTheme.theme,
        home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                return const HomeScreen();
              }
              return const SignUp();
            },
            error: (error, stackTrace) => ErrorPage(error: error.toString()),
            loading: () => const Loader()));
  }
}
/*
UI >> controller >> repositories
*/