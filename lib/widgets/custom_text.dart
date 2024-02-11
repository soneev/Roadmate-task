import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String? text;
  double? fontSize;

  TextAlign? textAlign;
  Color? color;
  bool? underline;
  FontWeight? fontWeight;
  int? maxLines;
  double? fontheight;
  String? fontFamily;
  Color? backgroundColor;

  CustomText(this.text,
      {super.key,
      this.fontSize,
      this.textAlign,
      this.color,
      this.fontWeight,
      this.underline = false,
      this.maxLines,
      this.fontheight,
      this.fontFamily,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.rubik(
          height: fontheight ?? 1,
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: fontSize ?? 16,
          color: color ?? const Color(0xff252525),
          decoration:
              underline! ? TextDecoration.lineThrough : TextDecoration.none,
          backgroundColor: backgroundColor),
    );
  }
}
