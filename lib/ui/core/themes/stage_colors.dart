import 'package:flutter/material.dart';

import '../../../domain/models/stage.dart';

class StageColors {
  const StageColors({required this.background, required this.foreground});

  final Color background;
  final Color foreground;

  static StageColors of(Stage stage) {
    return switch (stage) {
      Stage.saved => const StageColors(
        background: Color(0xFFF3F4F6),
        foreground: Color(0xFF4B5563),
      ),
      Stage.applied => const StageColors(
        background: Color(0xFFDBEAFE),
        foreground: Color(0xFF1E40AF),
      ),
      Stage.inProcess => const StageColors(
        background: Color(0xFFEDE9FE),
        foreground: Color(0xFF5B21B6),
      ),
      Stage.offering => const StageColors(
        background: Color(0xFFFEF3C7),
        foreground: Color(0xFF92400E),
      ),
      Stage.closed => const StageColors(
        background: Color(0xFFE2E8F0),
        foreground: Color(0xFF1E293B),
      ),
    };
  }
}
