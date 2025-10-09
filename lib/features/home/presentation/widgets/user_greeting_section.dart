import 'package:flutter/material.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/app_localizations.dart';

class UserGreetingSection extends StatelessWidget {
  const UserGreetingSection({
    super.key,
    required this.searchController,
    required this.onChanged,
    required this.userName,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onChanged;
  final String userName;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      color: colors.surface,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.greeting(userName),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          AppTextField(
            hintText: loc.searchHotspots,
            controller: searchController,
            prefixIcon: const Icon(Icons.search),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
