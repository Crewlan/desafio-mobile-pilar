import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_colors.dart';

class WordsCard extends StatelessWidget {
  final String? worldText;
  final VoidCallback? onTap;

  const WordsCard({
    Key? key,
    this.worldText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.lightest,
            border: Border.all(color: AppColors.darkest)),
        child: Center(
          child: Text(
            worldText ?? '',
            style: GoogleFonts.inter(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
