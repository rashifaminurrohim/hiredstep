import 'package:flutter/material.dart';
import 'package:hiredstep/ui/application_list/application_list_screen.dart';

import 'data/repositories/dummy_applications.dart';

void main() {
  runApp(const HiredStepApp());
}

class HiredStepApp extends StatelessWidget {
  const HiredStepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HiredStep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF0F766E),
        useMaterial3: true,
      ),
      home: ApplicationListScreen(applications: dummyApplications),
    );
  }
}
