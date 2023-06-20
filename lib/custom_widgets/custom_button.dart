import 'package:flutter/material.dart';
import 'package:todofirebase/custom_widgets/custom_text.dart';
import 'package:todofirebase/utils/app_colors.dart';
import 'package:todofirebase/utils/app_padding.dart';

class CustomButton extends StatelessWidget {
  late final Function() onTap;
  late final String title;
  late final Color containerColor, fontColor, borderColor;
  late final bool withBoxShadow;
  final double fontSize, horizontalPadding, width;
  final String? fontFamily;
  final bool? isloading;

  CustomButton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.isloading = false,
      this.containerColor = AppColors.lavendarColor,
      this.borderColor = AppColors.transparentColor,
      this.withBoxShadow = false,
      this.horizontalPadding = 16,
      this.fontSize = 18,
      this.width = AppPadding.FULL_SCREEN_WIDTH,
      this.fontFamily,
      this.fontColor = AppColors.whiteColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Container(
          width: width,
          decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor)),
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.BUTTON_VERTICAL_PADDING),
              child: Center(
                child: isloading == true
                    ? const CircularProgressIndicator(
                        color: AppColors.whiteColor,
                        strokeWidth: 2,
                      )
                    : CustomText(
                        text: title,
                        fontSize: fontSize,
                        fontColor: fontColor,
                        fontFamily: fontFamily,
                      ),
              )),
        ),
      ),
    );
  }
}
