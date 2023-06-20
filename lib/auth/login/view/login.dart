import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todofirebase/custom_widgets/custom_button.dart';
import 'package:todofirebase/custom_widgets/custom_text.dart';
import 'package:todofirebase/custom_widgets/textfield.dart';
import 'package:todofirebase/firebase/auth_firebase.dart';
import 'package:todofirebase/utils/app_colors.dart';
import 'package:todofirebase/utils/app_navigations.dart';
import 'package:todofirebase/utils/app_route_name.dart';
import 'package:todofirebase/utils/time_constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _loginFormKey = GlobalKey<FormState>();
  bool? loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 8.0, bottom: 8.0),
          child: Form(
            key: _loginFormKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _loginHereText(),
                  const SizedBox(
                    height: 10,
                  ),
                  _emailTextField(),
                  const SizedBox(
                    height: 10,
                  ),
                  _passwordTextField(),
                  const SizedBox(
                    height: 10,
                  ),
                  _loginButton(context),
                  const SizedBox(
                    height: 10,
                  ),
                  _dontHaveAnAccountText()
                ]),
          ),
        ),
      ),
    );
  }

  _loginHereText() {
    return const CustomText(
      text: "login here!",
      fontSize: 30,
      fontColor: AppColors.blackColor,
    );
  }

  _dontHaveAnAccountText() {
    return InkWell(
      onTap: (() {
        AppNavigation.navigateTo(context, AppRouteName.signupScreenRoute);
      }),
      child: const CustomText(
        text: "dont have an account? Sign up here.",
        fontSize: 19,
        fontColor: AppColors.blackColor,
      ),
    );
  }

  CustomTextfield _emailTextField() {
    return CustomTextfield(
      prefixIconPath: Icons.email,
      hintText: "Email address",
      keyboardType: TextInputType.emailAddress,
      controller: _emailCtrl,
    );
  }

  CustomTextfield _passwordTextField() {
    return CustomTextfield(
        prefixIconPath: Icons.lock,
        hintText: "Password",
        keyboardType: TextInputType.text,
        controller: _passwordCtrl,
        isSuffixIcon: true,
        isPasswordField: true);
  }

  CustomButton _loginButton(BuildContext context) {
    return CustomButton(
      onTap: () {
        if (_loginFormKey.currentState!.validate()) {
          _loginMethod();
        }
      },
      horizontalPadding: 0,
      isloading: loading,
      title: "Login",
      containerColor: AppColors.primaryColor,
    );
  }

  _loginMethod() async {
    setState(() {
      _emailCtrl.text = "user3@getnada.com";
      _passwordCtrl.text = "123456";
    });
    try {
      if (_loginFormKey.currentState!.validate()) {
        _loginFormKey.currentState!.save();
        setState(() {
          loading = true;
        });

        String result = await AuthMethods().logInUser(
          email: _emailCtrl.text,
          password: _passwordCtrl.text,
        );
        if (result == "success") {
          setState(() {
            loading = false;
          });
        }
        log("result  $result");
        if (result == 'success') {
          AppNavigation.navigateToRemovingAll(
              context, AppRouteName.homeScreenRoute);
        } else {
          // Navigator.pop(context);
          Utils.showSnackBar(
            context,
            "Incorrect password or email.",
          );
        }
      }
    } catch (e) {
      Utils.showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
