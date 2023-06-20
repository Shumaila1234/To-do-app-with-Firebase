import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todofirebase/firebase/auth_firebase.dart';
import 'package:todofirebase/custom_widgets/custom_button.dart';
import 'package:todofirebase/custom_widgets/custom_text.dart';
import 'package:todofirebase/custom_widgets/textfield.dart';
import 'package:todofirebase/utils/app_colors.dart';
import 'package:todofirebase/utils/app_navigations.dart';
import 'package:todofirebase/utils/app_route_name.dart';
import 'package:todofirebase/utils/time_constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();
  bool? loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 18.0, right: 18.0, top: 8.0, bottom: 8.0),
            child: Form(
              key: _signUpFormKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _loginHereText(),
                    const SizedBox(
                      height: 10,
                    ),
                    _nameTextField(),
                    const SizedBox(
                      height: 10,
                    ),
                    _emailField(),
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
                    _alreadyHaveAnAccountText()
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  _loginHereText() {
    return const CustomText(
      text: "signup here!",
      fontSize: 30,
      fontColor: AppColors.blackColor,
    );
  }

  CustomTextfield _nameTextField() {
    return CustomTextfield(
      prefixIconPath: Icons.person,
      hintText: "Name",
      keyboardType: TextInputType.text,
      controller: _nameCtrl,
      validator: ((value) {
        if (value!.isEmpty) {
          return "Please enter your name";
        }
      }),
    );
  }

  CustomTextfield _emailField() {
    return CustomTextfield(
      prefixIconPath: Icons.email,
      hintText: "Email Address",
      keyboardType: TextInputType.text,
      controller: _emailCtrl,
      validator: ((value) {
        if (value!.isEmpty) {
          return "Please enter your email address";
        }
      }),
    );
  }

  CustomTextfield _passwordTextField() {
    return CustomTextfield(
        prefixIconPath: Icons.lock,
        hintText: "Password",
        keyboardType: TextInputType.text,
        controller: _passwordCtrl,
        validator: ((value) {
          if (value!.length < 6) {
            return "Password lenght should be atleast 6 character.";
          }
        }),
        isSuffixIcon: true,
        isPasswordField: true);
  }

  CustomButton _loginButton(BuildContext context) {
    return CustomButton(
      onTap: () {
        if (_signUpFormKey.currentState!.validate()) {
          _signUpMethod();
        }
      },
      horizontalPadding: 0,
      isloading: loading,
      title: "Signup",
      containerColor: AppColors.primaryColor,
    );
  }

  _alreadyHaveAnAccountText() {
    return InkWell(
      onTap: (() {
        AppNavigation.navigateTo(context, AppRouteName.loginScreenRoute);
      }),
      child: const CustomText(
        text: "already have an account? Login here.",
        fontSize: 19,
        fontColor: AppColors.blackColor,
      ),
    );
  }

  _signUpMethod() async {
    try {
      if (_signUpFormKey.currentState!.validate()) {
        _signUpFormKey.currentState!.save();
        setState(() {
          loading = true;
        });

        String result = await AuthMethods().signUpUser(
          email: _emailCtrl.text,
          password: _passwordCtrl.text,
          username: _nameCtrl.text,
        );
        if (result == "success") {
          setState(() {
            loading = false;
          });
        }
        if (result == 'success') {
          AppNavigation.navigateToRemovingAll(
              context, AppRouteName.homeScreenRoute);
        } else {
          Utils.showSnackBar(
            context,
            "Email address is already exists.",
          );
        }
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      Utils.showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
