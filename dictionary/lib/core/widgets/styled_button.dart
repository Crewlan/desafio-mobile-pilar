import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../extensions/ui_helper_extension.dart';
import '../utils/app_colors.dart';

class StyledButton extends StatelessWidget {
  final String? text;
  final Function? action;
  final bool enabled;
  final bool usesInfinityWidth;
  final bool wrapContentWidth;
  final Color textColor;
  final Color backgroundColor;
  final Color outlineColor;
  final double fontSize;
  final double borderRadius;
  final TextAlign? textAlign;

  const StyledButton(
      {Key? key,
      this.text,
      this.action,
      this.enabled = true,
      this.usesInfinityWidth = false,
      this.textColor = AppColors.lightest,
      this.backgroundColor = AppColors.neutralDarkest,
      this.outlineColor = Colors.transparent,
      this.wrapContentWidth = false,
      this.fontSize = 14,
      this.borderRadius = 12,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: wrapContentWidth
          ? null
          : usesInfinityWidth
              ? double.infinity
              : context.height * 1 - 64,
      child: TextButton(
        onPressed: _buttonAction() as void Function()?,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          side: BorderSide(color: outlineColor),
          foregroundColor: textColor,
          backgroundColor: _buttonAction() != null ? backgroundColor : AppColors.lightest,
          textStyle: GoogleFonts.montserrat(
            color: enabled ? textColor : AppColors.darkest,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text(
          text ?? '',
          textAlign: textAlign,
        ),
      ),
    );
  }

  Function? _buttonAction() {
    return enabled ? action : null;
  }
}
