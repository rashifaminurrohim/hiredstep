import 'package:flutter/material.dart';

import '../../../domain/models/status.dart';
import '../themes/stage_colors.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.status, super.key});

  final Status status;

  @override
  Widget build(BuildContext context) {
    final colors = StageColors.of(status.stage);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status.name,
        style: TextStyle(
          color: colors.foreground,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
