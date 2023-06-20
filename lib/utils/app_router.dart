import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todofirebase/auth/login/view/login.dart';
import 'package:todofirebase/core/add_task/arguments/add_task_arguments.dart';
import 'package:todofirebase/core/add_task/view/add_task.dart';
import 'package:todofirebase/core/animation_screen/animation_screen.dart';
import 'package:todofirebase/core/home/view/home.dart';
import 'package:todofirebase/auth/signup/view/signup.dart';
import 'package:todofirebase/utils/app_route_name.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case AppRouteName.loginScreenRoute:
            return Login();
          case AppRouteName.signupScreenRoute:
            return SignUp();

          case AppRouteName.homeScreenRoute:
            return Home();

          case AppRouteName.addTaskRoute:
            AddTaskArguments? addTaskArguments =
                routeSettings.arguments as AddTaskArguments?;
            return AddTask(
              isFromEdit: addTaskArguments?.isFromEdit ?? false,
              taskTitle: addTaskArguments?.taskTitle ?? "",
              taskDate: addTaskArguments?.taskDate ?? "",
              taskTime: addTaskArguments?.taskTime ?? "",
              taskId: addTaskArguments?.taskId ?? "0",
            );

          case AppRouteName.animationScreenRoute:
            return AnimationScreen();

          default:
            return Container();
        }
      },
    );
  }
}
