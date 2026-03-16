import 'package:flutter/material.dart';
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
        fillColor: const Color(0xffF8FAFC), // اللون الفاتح من التصميم
        // استخدام label بدلاً من hintText لضمان التصاق الأيقونة بالكلام في البداية
        label: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start, // المحاذاة لليسار
          children: [
            ?prefixIcon,
            if (prefixIcon != null)
              const SizedBox(width: 10), // المسافة بين الأيقونة والكلمة
            Text(
              hintText ?? "",
              style: TextStyles.caption1.copyWith(
                color:AppColors.accentGrey,
              ),
            ),
          ],
        ),

        floatingLabelBehavior: FloatingLabelBehavior.never, // يختفي عند الكتابة

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),

        // الـ Padding الأفقي يضمن مسافة احترافية من طرف الحقل
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
