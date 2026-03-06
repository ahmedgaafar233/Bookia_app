import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.radius,
    this.borderColor,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? radius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primaryColor,
          foregroundColor: textColor ?? AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor ?? AppColors.white,
          ),
        ),
      ),
    );
  }
}
