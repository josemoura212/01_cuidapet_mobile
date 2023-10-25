import 'package:flutter/material.dart';

import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';

class CuidapetDefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double borderRadius;
  final Color? color;
  final Color? labelColor;
  final double? labelSize;
  final double padding;
  final double width;
  final double heigth;

  const CuidapetDefaultButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.borderRadius = 10,
    this.color,
    this.labelColor,
    this.labelSize = 20,
    this.padding = 10,
    this.width = double.infinity,
    this.heigth = 66,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: heigth,
      padding: EdgeInsets.all(padding),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: color ?? context.primaryColor,
          // minimumSize: Size.fromHeight(45.h),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            color: labelColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
