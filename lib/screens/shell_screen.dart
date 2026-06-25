import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pitwall/core/theme.dart';
import 'package:hugeicons/hugeicons.dart';

class ShellScreen extends StatelessWidget {
  final Widget child;
  const ShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;
    if (location.startsWith('/races')) currentIndex = 1;
    if (location.startsWith('/drivers')) currentIndex = 2;
    if (location.startsWith('/standings')) currentIndex = 3;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        indicatorColor: F1Colors.red,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: F1Colors.background,
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/races');
              break;
            case 2:
              context.go('/drivers');
              break;
            case 3:
              context.go('/standings');
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedDashboardSquare01),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedDashboardSquare01,
            ),
            label: 'Home',
          ),

          NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedFlag01),
            selectedIcon: HugeIcon(icon: HugeIcons.strokeRoundedFlag01),
            label: 'Races',
          ),

          NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedUserGroup),
            selectedIcon: HugeIcon(icon: HugeIcons.strokeRoundedUserGroup),
            label: 'Drivers',
          ),

          NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedRanking),
            selectedIcon: HugeIcon(icon: HugeIcons.strokeRoundedRanking),
            label: 'Standings',
          ),
        ],
      ),
    );
  }
}
