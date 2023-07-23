import 'package:dictionary/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StyledErrorWidget extends StatelessWidget {
  final String? msgError;
  final String? titleError;
  final String? msgButtonRetry;
  final Function? onRetry;
  final bool showIcon;
  const StyledErrorWidget({
    Key? key,
    required this.msgError,
    this.titleError,
    this.msgButtonRetry,
    this.onRetry,
    this.showIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            titleError ?? AppStrings.atention,
            style: const TextStyle(fontFamily: 'Montserrat', fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            msgError ?? '',
            style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          if (onRetry != null)
            InkWell(
              onTap: onRetry as void Function()?,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      msgButtonRetry ?? AppStrings.tryAgain,
                      style: const TextStyle(fontFamily: 'Montserrat', decoration: TextDecoration.underline),
                    ),
                    const SizedBox(width: 8),
                    const Icon(MdiIcons.reload)
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
