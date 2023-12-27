import 'package:flutter/material.dart';

import 'app/app.dart';
import 'services/shared_preferences_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager().init();

  runApp(const MyApp());
}
