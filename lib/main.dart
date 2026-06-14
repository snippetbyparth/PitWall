import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pitwall/core/theme.dart';
import 'package:pitwall/screens/splash_screen.dart';
import 'package:pitwall/core/router.dart';

void main(){
  runApp(const ProviderScope(child: PitWallApp()));
}


class PitWallApp extends StatelessWidget {
  const PitWallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PitWall',
      debugShowCheckedModeBanner: false,
      theme: F1Theme.darkTheme,
      routerConfig: router,
    );
  }
}