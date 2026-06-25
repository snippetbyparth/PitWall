import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitwall/core/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pitwall/screens/home/widgets/race_countdown_card.dart';
import 'package:pitwall/screens/home/widgets/race_podium_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: F1Colors.background,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: F1Colors.red, width: 1),
                ),
              ),
              child: Text(
                'PITWALL',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: F1Colors.white),
              title: Text('Settings', style: TextStyle(color: F1Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: F1Colors.background,
        iconTheme: const IconThemeData(color: F1Colors.red),
        title: Text(
          'PitWall',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RaceCountdownCard(),
            const SizedBox(height: 10,),
            const RacePodiumCard()
          ],
        ),
      ),
    );
  }
}
