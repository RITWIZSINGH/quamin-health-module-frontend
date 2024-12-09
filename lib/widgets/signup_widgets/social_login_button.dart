import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String assetName;
  final Color backgroundColor;

  const SocialLoginButton({
    super.key,
    required this.onPressed,
    required this.assetName,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            assetName,
            colorFilter: backgroundColor != Colors.white
                ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                : null,
          ),
        ),
      ),
    );
  }
}