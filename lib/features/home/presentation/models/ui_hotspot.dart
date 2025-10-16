// lib/features/home/presentation/models/ui_hotspot.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_styles.dart';
import '../../domain/entities/hotspot_entity.dart';

extension HotspotUiX on HotspotEntity {
  Color statusColor(BuildContext context) =>
      isActive ? AppColors.of(context).statusActive : AppColors.of(context).hint;

  Color roleBadgeColor(BuildContext context) {
    final c = AppColors.of(context);
    switch (role) {
      case HotspotRole.owner:
        return c.ownerBadge;
      case HotspotRole.assistant:
        return c.assistantBadge;
      case HotspotRole.vendor:
        return c.vendorBadge;
    }
  }
}
