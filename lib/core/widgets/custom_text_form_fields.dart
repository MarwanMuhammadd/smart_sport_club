import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.enabled = true,
    this.onTap,
    this.onChanged,
    this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscureText = false,
    this.fillColor,
    this.borderRadius,
  });

  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final int minLines;
  final int maxLines;
  final bool obscureText;
  final Color? fillColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.start, // يبدأ النص المكتوب من الشمال
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            fillColor ?? const Color(0xffF8FAFC), // اللون الفاتح من التصميم
        label: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ?prefixIcon,
            if (prefixIcon != null) SizedBox(width: 10.w),
            Text(
              hintText ?? "",
              style: TextStyles.caption1.copyWith(color: AppColors.blackColor),
            ),
          ],
        ),

        floatingLabelBehavior: FloatingLabelBehavior.never,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius?.w ?? 15.w),
          borderSide: BorderSide.none,
        ),

        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
