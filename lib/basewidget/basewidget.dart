import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todofirebase/auth/login/view/login.dart';
import 'package:todofirebase/utils/app_colors.dart';
import 'package:todofirebase/utils/app_router.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: AppRouter.onGenerateRoute,
        color: Colors.blue,
        debugShowCheckedModeBanner: false,
        title: 'Todo App with Firebase',
        theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            primarySwatch: AppColors.kPrimaryColor,
            scaffoldBackgroundColor: AppColors.lavendarColor),
        home: const Login());
  }
}
