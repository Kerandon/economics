import 'package:economics_app/configs/constants.dart';
import 'package:economics_app/configs/theme_data.dart';
import 'package:economics_app/state/app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'pages/home_page/home_page.dart';

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
  const EconApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {final appState = ref.watch(appProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        title: kAppName,
        theme: CustomAppTheme(appState, context).appTheme,
        home: const HomePage());
  }
}
