import 'package:flutter/material.dart';
import 'package:todofirebase/utils/app_colors.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final Color fontColor;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final bool underlined, lineThrough;
  final String? fontFamily;
  final double fontSize, lineSpacing, letterSpacing;
  final int? maxLines;
  final TextOverflow overflow;

  const CustomText({
    this.text,
    this.fontColor = AppColors.blackColor,
    this.fontSize = 15,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.normal,
    this.underlined = false,
    this.lineSpacing = 1,
    this.letterSpacing = 0,
    this.maxLines,
    this.fontFamily,
    this.overflow = TextOverflow.ellipsis,
    this.lineThrough = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : overflow,
      textAlign: textAlign,
      style: TextStyle(
        color: fontColor,
        fontWeight: fontWeight,
        height: lineSpacing,
        letterSpacing: letterSpacing,
        fontSize: fontSize,
        fontFamily: fontFamily,
        decorationThickness: 1.0,
        decoration: underlined
            ? TextDecoration.underline
            : (lineThrough ? TextDecoration.lineThrough : TextDecoration.none),
      ),
    );
  }
}
