import 'package:flutter/material.dart';
import 'package:todofirebase/custom_widgets/custom_text.dart';
import 'package:todofirebase/utils/app_colors.dart';
import 'package:todofirebase/utils/app_padding.dart';

AppBar customAppBar({String? text}) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: AppColors.primaryColor,
    title: CustomText(
      text: text ?? "",
      fontSize: AppPadding.appBarFontSize,
      fontColor: AppColors.lavendarColor,
    ),
  );
}
