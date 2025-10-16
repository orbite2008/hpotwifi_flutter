// lib/core/widgets/horizontal_tab_bar.dart

import 'package:flutter/material.dart';
import 'custom_tab_button.dart';

/// Modèle pour un item de tab
class TabItem {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });
}

class HorizontalTabBar extends StatelessWidget {
  final List<TabItem> tabs;
  final EdgeInsets padding;
  final double spacing;

  const HorizontalTabBar({
    super.key,
    required this.tabs,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: padding,
        child: Row(
          children: tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;

            return Padding(
              padding: EdgeInsets.only(
                right: index < tabs.length - 1 ? spacing : 0,
              ),
              child: CustomTabButton(
                label: tab.label,
                isSelected: tab.isSelected,
                onTap: tab.onTap,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
