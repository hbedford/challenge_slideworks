import 'package:challenge_slideworks/ui/app.dart';
import 'package:challenge_slideworks/ui/form/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() {
  final String key = 'SUA_KEY';
  final String token = "SEU_TOKEN";
  final getIt = GetIt.instance;
  getIt.registerSingleton<FormController>(
      FormController(key: key, token: token));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}
