import 'package:flutter/material.dart';

import '../shared/theme/app_text_style.dart';
import '../shared/theme/color_style.dart';

class FilterChipButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected ? AppColors.black80 : AppColors.white;
    final textColor = isSelected ? AppColors.white : AppColors.blackTitle;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.blackTitle),
        ),
        child: Text(label, style: AppTextStyle.text.copyWith(color: textColor)),
      ),
    );
  }
}
