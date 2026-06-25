import 'package:go_router/go_router.dart';
import 'package:pitwall/screens/home/home_screen.dart';
import 'package:pitwall/screens/splash_screen.dart';
import 'package:pitwall/screens/shell_screen.dart';
import 'package:flutter/material.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    ShellRoute(
      builder: (context, state, child) => ShellScreen(child: child),
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/races', builder: (context, state) => const Placeholder()),
        GoRoute(path: '/drivers', builder: (context, state) => const Placeholder()),
        GoRoute(path: '/standings',builder: (context, state) => const Placeholder()),
      ],
    ),
  ],
);
