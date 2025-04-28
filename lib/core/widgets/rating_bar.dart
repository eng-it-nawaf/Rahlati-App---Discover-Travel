import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final int rating;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;

  const RatingBar(
      this.rating, {
        this.iconSize = 20,
        this.activeColor = Colors.white70,
        this.inactiveColor = Colors.white30,
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: iconSize,
          color: index < rating ? activeColor : inactiveColor,
        );
      }),
    );
  }
}