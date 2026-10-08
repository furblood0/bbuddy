import 'package:flutter/material.dart';

class ScreenHeader extends StatelessWidget implements PreferredSizeWidget {
  final IconData icon;
  final String title;
  final List<Widget>? actions;

  const ScreenHeader({
    super.key,
    required this.icon,
    required this.title,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withValues(alpha: 0.82),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.28),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: colorScheme.onPrimary, size: 18),
          ),
          const SizedBox(width: 12),
          Text(title),
        ],
      ),
      actions: actions,
    );
  }
}
