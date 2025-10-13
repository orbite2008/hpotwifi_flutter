// lib/core/widgets/user_list_item.dart

import 'package:flutter/material.dart';
import '../theme/app_styles.dart';

class UserListItem extends StatelessWidget {
  final String userId;
  final String status;
  final String packageInfo;
  final bool isConnected;

  const UserListItem({
    super.key,
    required this.userId,
    required this.status,
    required this.packageInfo,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colors.border.withOpacity(0.3)),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.disabled,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: colors.textSecondary, size: 24),
          ),
          const SizedBox(width: 12),
          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userId,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 13,
                    color: isConnected ? Colors.green : colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Package info
          Text(
            packageInfo,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
