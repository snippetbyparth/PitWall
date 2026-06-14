import 'package:go_router/go_router.dart';
import 'package:pitwall/screens/home/home_screen.dart';
import 'package:pitwall/screens/splash_screen.dart';


final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/',
    builder: (context, state) => const SplashScreen(),),
    GoRoute(path: '/home',
    builder: (context, state) => const HomeScreen(),)
  ]);


  