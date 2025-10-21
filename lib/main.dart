import 'package:flutter/material.dart';
import 'app/setup.dart';
import 'ui/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const PulseboardApp());
}
