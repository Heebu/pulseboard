import 'package:flutter/material.dart';
import 'views/dashboard/dashboard_view.dart';

class PulseboardApp extends StatelessWidget {
  const PulseboardApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Pulseboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const DashboardView(),
    );
  }
}
