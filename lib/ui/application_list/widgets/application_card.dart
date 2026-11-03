import 'package:flutter/material.dart';
import 'package:hiredstep/utils/date_format.dart';

import '../../../domain/models/application.dart';
import '../../core/widgets/status_badge.dart';

class ApplicationCard extends StatelessWidget {
  const ApplicationCard({required this.application, this.onTap, super.key});

  final Application application;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appliedAt = application.appliedAt;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(application.company, style: textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(application.position, style: textTheme.bodyMedium),
                    if (appliedAt != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        'Applied on ${formatDate(appliedAt)}',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              StatusBadge(status: application.status),
            ],
          ),
        ),
      ),
    );
  }
}
