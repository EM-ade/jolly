import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: unused_local_variable
  final prefs = await SharedPreferences.getInstance();
  // We can use prefs later for persistent state if needed

  runApp(const ProviderScope(child: MyApp()));
}
