import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _appSetup();
  runApp(const MyApp());
}

Future<void> _appSetup() async {
  await dotenv.load();
}
