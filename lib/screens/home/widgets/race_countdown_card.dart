import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pitwall/core/theme.dart';
import 'package:pitwall/providers/home_provider.dart';
import 'package:shimmer/shimmer.dart';

class RaceCountdownCard extends ConsumerWidget {
  const RaceCountdownCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeDataProvider);
    return homeData.when(
      loading: () => const _LoadingCard(),
      error: (error, stack) => _ErrorCard(message: error.toString()),
      data: (data) {
        final races = data['raceSchedule'] as List;
        final now = DateTime.now();
        final upcoming = races.firstWhere(
          (race) => DateTime.parse(race['date']).isAfter(now),
          orElse: () => null,
        );
        if (upcoming == null) {
          return const _ErrorCard(message: 'No upcoming race found');
        }
        return _CountdownContent(race: upcoming);
      },
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: F1Colors.card,
      highlightColor: F1Colors.surface,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: F1Colors.card,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String message;
  const _ErrorCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: F1Colors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: F1Colors.red.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: F1Colors.red),
          const SizedBox(height: 8),
          Text(
            'Failed to load race data',
            style: TextStyle(color: F1Colors.lightGrey, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {},
            child: Text('Retry', style: TextStyle(color: F1Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _CountdownContent extends StatelessWidget {
  final Map race;
  const _CountdownContent({required this.race});

  @override
  Widget build(BuildContext context) {
    final raceName = race['raceName'] as String;
    final circuitName = race['Circuit']['circuitName'] as String;
    final country = race['Circuit']['Location']['country'] as String;

    final dateStr = race['date'] as String;
    final timeStr = race['time'] as String? ?? '00:00:00Z';
    final raceDateTime = DateTime.parse('${dateStr}T$timeStr');

    final now = DateTime.now().toUtc();
    final difference = raceDateTime.difference(now);
    final days = difference.inDays;
    final hours = difference.inHours % 24;

    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: F1Colors.card,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              country.toUpperCase(),
              style: TextStyle(color: F1Colors.red, fontSize: 12, letterSpacing: 2),
            ),
            const SizedBox(height: 4),
            Text(
              raceName,
              style: TextStyle(color: F1Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              circuitName,
              style: TextStyle(color: F1Colors.lightGrey, fontSize: 13),
            ),
            const SizedBox(height: 16),
            Text(
              '$days days $hours hrs',
              style: TextStyle(color: F1Colors.red, fontSize: 28, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}