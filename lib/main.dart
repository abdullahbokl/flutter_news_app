import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bloc_observer.dart';
import 'core/utils/service_locator.dart';
import 'news_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _appSetup();
  runApp(const NewsApp());
}

Future<void> _appSetup() async {
  Bloc.observer = MyBlocObserver();
  setupServiceLocator();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint(e.toString());
  }
}
