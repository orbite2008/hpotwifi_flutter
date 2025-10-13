// lib/core/widgets/search_filter_bar.dart

import 'package:flutter/material.dart';
import '../theme/app_styles.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final VoidCallback? onFilterTap;

  const SearchFilterBar({
    super.key,
    this.controller,
    this.hintText = 'Rechercher',
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: colors.hint, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: colors.hint),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: onFilterTap,
            child: Icon(Icons.tune, color: colors.textPrimary, size: 20),
          ),
        ],
      ),
    );
  }
}
