import 'package:admin_project/firebase_options.dart';
import 'package:admin_project/providers/event_provider.dart';
import 'package:admin_project/providers/song_provider.dart';
import 'package:admin_project/screens/Auth/login_screen.dart';
import 'package:admin_project/screens/Dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'extras/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kIsWeb) {
    await FirebaseAuth.instance.authStateChanges().first;
  }
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<SongProvider>(create: (_)=>SongProvider()),
        ChangeNotifierProvider<EventProvider>(create: (_)=>EventProvider())
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: CColors.getMaterialColor(),
      ),
      home: const Landing(),
    );
  }
}

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser == null){
      return LoginScreen();
    }else{
      return DashBoardScreen();
    }

  }
}

