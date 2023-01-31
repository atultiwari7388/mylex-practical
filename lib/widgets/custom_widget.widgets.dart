import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.borderRadius,
    required this.function,
    required this.buttonWidth,
  }) : super(key: key);

  final BorderRadius? borderRadius;
  final Function function;
  final double buttonWidth;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => function(),
      child: Material(
        elevation: 5,
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        color: Colors.deepPurple,
        child: SizedBox(
          height: size.height / 17,
          width: size.width / buttonWidth,
          child: Center(
              child: FaIcon(FontAwesomeIcons.arrowRight, color: Colors.white)),
        ),
      ),
    );
  }
}
