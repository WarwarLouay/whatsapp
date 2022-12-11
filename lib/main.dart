// ignore_for_file: prefer_const_constructors, duplicate_ignore, deprecated_member_use, import_of_legacy_library_into_null_safe

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp/models/user_model.dart';
import 'package:whatsapp/screens/camera_screen.dart';
import 'package:whatsapp/screens/landing_screen.dart';
import 'package:whatsapp/screens/login_screen.dart';

import './screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserModel(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'OpenSans',
            primarySwatch: Colors.teal,
            accentColor: Color(0xFF128C7E),
          ),
          // ignore: prefer_const_constructors
          home: LandingScreen()),
    );
  }
}
