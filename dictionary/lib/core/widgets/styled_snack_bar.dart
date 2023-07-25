import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../utils/app_colors.dart';

class StyledSnackbar {
  final BuildContext context;
  final Widget icon;
  final bool isDefault;
  final int durationSeconds;

  List<BoxShadow> boxShadow = [
    BoxShadow(
      color: AppColors.boxShadowColor1.withOpacity(0.16),
      blurRadius: 7,
      spreadRadius: 0,
      offset: const Offset(0, 3),
    )
  ];

  StyledSnackbar(
    this.context, {
    this.durationSeconds = 2,
    this.icon = const Icon(MdiIcons.checkCircleOutline, color: AppColors.neutralDarkest),
    this.isDefault = true,
  });

  void showSuccess(String message, {Function? callBack}) {
    Navigator.of(context, rootNavigator: true)
        .push(
          showFlushbar(
            context: context,
            flushbar: Flushbar(
              margin: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              flushbarPosition: FlushbarPosition.TOP,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              backgroundColor: AppColors.lightest,
              icon: const Icon(MdiIcons.checkCircleOutline, color: AppColors.success),
              boxShadows: boxShadow,
              duration: Duration(seconds: durationSeconds),
              messageText: Text(
                message,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: AppColors.success,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        )
        .then(
          (value) => Future.delayed(
            Duration(seconds: durationSeconds),
            () {
              if (callBack != null) {
                callBack();
              }
            },
          ),
        );
  }
}
