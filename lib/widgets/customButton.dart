import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnerapp/utils/route/color/app_colors.dart';
import 'package:partnerapp/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.height,
      this.width,
      this.color,
      this.text,
      this.radius,
      this.onTap,
      this.textcolor});
  final double? width, height, radius;
  final Color? color;
  final String? text;
  final Function()? onTap;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: onTap,
        minWidth: width ?? 1.sw,
        height: height ?? 50,
        color: color ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10)),
        child: CustomText(
          text,
          color: textcolor,
        ),
      ),
    );
  }
}

class CustomButtonBase extends StatelessWidget {
  const CustomButtonBase(
      {super.key,
      this.height,
      this.width,
      this.text,
      this.onTap,
      this.color,
      this.textColor,
      this.borderColor,
      this.fontSize});
  final double? width, height;
  final String? text;
  final Function()? onTap;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 45,
        width: width ?? 1.sw,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10),
            color: color),
        child: Center(
          child: CustomText(
            text,
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
