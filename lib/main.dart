import 'package:flutter/material.dart';
import 'package:hiredstep/data/repositories/application_repository.dart';
import 'package:hiredstep/data/repositories/in_memory_application_repository.dart';
import 'package:hiredstep/ui/application_list/application_list_screen.dart';
import 'package:hiredstep/ui/application_list/view_models/application_list_view_model.dart';
import 'package:provider/provider.dart';

import 'data/repositories/dummy_applications.dart';

void main() {
  runApp(const HiredStepApp());
}

class HiredStepApp extends StatelessWidget {
  const HiredStepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApplicationRepository>(
          create: (context) =>
              InMemoryApplicationRepository(seed: dummyApplications),
        ),
        ChangeNotifierProvider(
          create: (context) => ApplicationListViewModel(
            repository: context.read<ApplicationRepository>(),
          )..load(),
        ),
      ],
      child: MaterialApp(
        title: 'HiredStep',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF0F766E),
          useMaterial3: true,
        ),
        home: const ApplicationListScreen(),
      ),
    );
  }
}
