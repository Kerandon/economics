import 'package:economics_app/app/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app/configs/constants.dart';
import 'app/configs/theme_data.dart';
import 'app/state/app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const firebaseOptions = FirebaseOptions(
      apiKey: "AIzaSyAZrccyrnsXRA_D3tAU7pHdaZLkhANvDu8",
      authDomain: "economics-app.firebaseapp.com",
      projectId: "economics-app",
      storageBucket: "economics-app.appspot.com",
      messagingSenderId: "449972201177",
      appId: "1:449972201177:web:079dc531240152efe940c8",
      measurementId: "G-769JN4PQ14");

  if(kIsWeb){

    await Firebase.initializeApp(
      options: firebaseOptions,
    );
  }else{
    await Firebase.initializeApp();
  }

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
      home: const HomePage(),
      //const HomePage(),
    );
  }
}
