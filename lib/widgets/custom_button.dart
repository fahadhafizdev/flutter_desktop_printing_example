import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/config.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final Function() func;
  final String text;
  final ButtonStyle btnStyle;
  final Color textColor;
  final FontWeight? fontWeight;
  final Widget? prefix;
  final EdgeInsets margin;
  final double fontSize;
  final double? width;

  const CustomButton({
    super.key,
    required this.isLoading,
    required this.func,
    required this.text,
    required this.btnStyle,
    this.fontSize = 0,
    this.prefix,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.w700,
    this.margin = const EdgeInsets.all(0),
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 35,
      width: width,
      child: ElevatedButton(
        style: btnStyle,
        onPressed: func,
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: textColor,
                  strokeWidth: 3.0,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  prefix ?? const SizedBox.shrink(),
                  prefix == null
                      ? const SizedBox.shrink()
                      : const SizedBox(width: 12),
                  Text(
                    text,
                    style: AppFont.interWhite1.copyWith(
                      fontWeight: fontWeight,
                      color: textColor,
                      fontSize: fontSize == 0 ? 14 : fontSize,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
