
import 'package:economics_app/sections/quizzes/quiz_init_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'app/audio_manager/audio_manager.dart';
import 'app/configs/constants.dart';
import 'app/configs/theme_data.dart';
import 'app/state/app_state.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final dir = await getApplicationDocumentsDirectory();


  const firebaseOptions = FirebaseOptions(
      apiKey: "AIzaSyAZrccyrnsXRA_D3tAU7pHdaZLkhANvDu8",
      authDomain: "economics-app.firebaseapp.com",
      projectId: "economics-app",
      storageBucket: "economics-app.appspot.com",
      messagingSenderId: "449972201177",
      appId: "1:449972201177:web:079dc531240152efe940c8",
      measurementId: "G-769JN4PQ14");

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: firebaseOptions,
    );
  } else {
    try {
    await Firebase.initializeApp();
    } catch (e) {
      throw Exception('Firestore initialization error: $e');
    }

  }

  getIt.registerSingleton<AudioManager>(AudioManager());

  runApp(const ProviderScope(child: EconApp()));
}

class EconApp extends ConsumerWidget {
  const EconApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: CustomAppTheme(appState, context).appTheme,
      home: const QuizInitPage(),
    );
  }
}
