import 'package:economics_app/sections/diagrams/all_diagrams_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app/configs/constants.dart';
import 'app/configs/theme_data.dart';
import 'app/state/app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: EconApp()));
}

class EconApp extends ConsumerWidget {
  const EconApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: kAppName,
      theme: CustomAppTheme(appState, context).appTheme,
      home: const AllDiagramsPage(),
      //const HomePage(),
    );
  }
}
