import 'package:flutter/material.dart';
import '../../res/constants.dart';

class CircularSoftButton extends StatelessWidget {
  final double? radius;
  final Widget? icon;
  final Color lightColor;
  const CircularSoftButton(
      {super.key, this.radius, this.icon, this.lightColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    double? myRadius = radius;
    if (radius == null || radius! <= 0) myRadius = 32;
    return Padding(
      padding: EdgeInsets.all(myRadius! / 2),
      child: Stack(
        children: <Widget>[
          Container(
            width: myRadius * 2,
            height: myRadius * 2,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(myRadius),
              boxShadow: [
                BoxShadow(
                    color: shadowColor,
                    offset: const Offset(8, 6),
                    blurRadius: 12),
                BoxShadow(
                    color: lightColor,
                    offset: const Offset(-8, -6),
                    blurRadius: 12),
              ],
            ),
          ),
          Positioned.fill(child: icon!),
        ],
      ),
    );
  }
}
