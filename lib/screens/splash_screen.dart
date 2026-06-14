import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pitwall/core/theme.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status==AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), (){
          if (mounted) context.go('/home');
        });
      }
    },);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: F1Colors.background,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: 
                    Image.asset(
                      'assets/images/F1_logo.png',
                      width: 200,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 0,),
                FadeTransition(opacity: _fadeAnimation,child: Text('PitWall',
                style: GoogleFonts.rajdhani(
                  color: F1Colors.red,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 8,
                ),),)
              ],
            ),
          );
        },
      ),
    );
  }
}
