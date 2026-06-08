import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({super.key, required this.imageUrl, required this.icon, this.onTap, this.imageFile});

  final String imageUrl;
  final File? imageFile;
  final IconData icon;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 112.w, // 28 * 4 from tailwind w-28
          height: 112.w,
          padding: EdgeInsets.all(4.w), // p-1 equivalent
          decoration:  BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryColor, // using primary and green to match the theme
                AppColors.primaryGreen,
              ],
            ),
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4.w),
              color: Colors.white,
            ),
            child: _buildImageWidget(),
          ),
        ),
        Positioned(
          bottom: 4.w,
          right: 4.w,
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.w),
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Icon(icon, color: Colors.white, size: 16.w),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageWidget() {
    if (imageFile != null) {
      return Image.file(
        imageFile!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    if (imageUrl.endsWith('.svg')) {
      return SafeSvgPicture(
        assetName: imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        fallback: Container(
          color: const Color(0xffDDDFE4),
          alignment: Alignment.center,
          child: Icon(
            Icons.person,
            size: 64.w,
            color: const Color(0xff8997B3),
          ),
        ),
      );
    }
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return SafeSvgPicture(
          assetName: AppImages.userAvatarPlaceholderSvg,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          fallback: Container(
            color: const Color(0xffDDDFE4),
            alignment: Alignment.center,
            child: Icon(
              Icons.person,
              size: 64.w,
              color: const Color(0xff8997B3),
            ),
          ),
        );
      },
    );
  }
}

class SafeSvgPicture extends StatefulWidget {
  final String assetName;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget fallback;

  const SafeSvgPicture({
    super.key,
    required this.assetName,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    required this.fallback,
  });

  @override
  State<SafeSvgPicture> createState() => _SafeSvgPictureState();
}

class _SafeSvgPictureState extends State<SafeSvgPicture> {
  bool _hasError = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAsset();
  }

  Future<void> _checkAsset() async {
    try {
      await DefaultAssetBundle.of(context).load(widget.assetName);
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return widget.fallback;
    }
    return SvgPicture.asset(
      widget.assetName,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
    );
  }
}
