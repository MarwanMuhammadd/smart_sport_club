import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/custom_text_form_fields.dart';

class TextFieldWithlabel extends StatelessWidget {
  final String label;
  final String hint;
  final String path;
  final Widget? suffixIcon; // دلوقتي اختياري
  final String? Function(String?)? validator;
  final bool obscureText; // محتاج default false
  final TextEditingController? controller;

  const TextFieldWithlabel({
    super.key,
    required this.label,
    required this.hint,
    required this.path,
    this.validator,
    this.suffixIcon, // اختياري دلوقتي
    this.obscureText = false, // default false
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.caption1.copyWith(color: Color(0xff475569)),
        ),
        8.H,
        CustomTextFormField(
          controller: controller,
          obscureText: obscureText,
          suffixIcon: suffixIcon, // لو مفيش suffixIcon، يبقى null
          validator: validator,
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.w),
            child: SvgPicture.asset(path, width: 20.w, height: 20.w),
          ),
          hintText: hint,
        ),
      ],
    );
  }
}
