import 'package:flutter/material.dart';

class TopSquareBoxWidget extends StatelessWidget {
  const TopSquareBoxWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    required this.borderRadius,
    required this.child,
    required this.shadowColor,
    required this.blurRadius,
  }) : super(key: key);

  final double height;
  final double width;
  final Color color, shadowColor;
  final double borderRadius, blurRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
              color: shadowColor, offset: Offset(1, 1), blurRadius: blurRadius),
        ],
      ),
      child: child,
    );
  }
}
