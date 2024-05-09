import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_check/firebase_options.dart';
import 'package:keep_in_check/services/connectivity_service.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'services/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SharedPreferencesService().init();
  ConnectivityService().initialize();

  runApp(StreamProvider<ConnectivityResult>(
    create: (context) =>
        Connectivity().onConnectivityChanged.map((results) => results.first),
    initialData: ConnectivityResult.none,
    child: const MyApp(),
  ));
}
