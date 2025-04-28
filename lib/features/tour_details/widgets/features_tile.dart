import 'package:discounttour/core/constants/app_colors.dart' show AppColors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show StatelessWidget, Tooltip;

class FeaturesTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const FeaturesTile({
    required this.icon,
    required this.label,
    this.iconColor = const Color(0xff5A6C64),
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background,
            ),
            child: Icon(icon, color: iconColor),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}