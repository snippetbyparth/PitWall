import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pitwall/core/theme.dart';
import 'package:pitwall/providers/home_provider.dart';
import 'package:shimmer/shimmer.dart';

class RacePodiumCard extends ConsumerWidget {
  const RacePodiumCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeDataProvider);
    return homeData.when(
      loading: () => const _LoadingCard(),
      error: (error, stack) => _ErrorCard(message: error.toString()),
      data: (data) {
        final results = data['latestResults'] as List;
        if (results.length < 3) {
          return const _ErrorCard(message: 'Incomplete race results');
        }
        return _PodiumContent(results: results);
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
        height: 160,
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
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: F1Colors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: F1Colors.red.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: F1Colors.red, size: 32),
          const SizedBox(height: 8),
          Text(
            'Failed to load race results',
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

class _PodiumContent extends StatelessWidget {
  final List results;
  const _PodiumContent({required this.results});

  @override
  Widget build(BuildContext context) {
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
              'LATEST RACE PODIUM',
              style: TextStyle(
                color: F1Colors.red,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            for (int i = 0; i < 3; i++) _buildPodiumRow(results[i], i),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumRow(dynamic result, int index) {
    final position = index + 1;
    final driverName =
        '${result['Driver']['givenName']} ${result['Driver']['familyName']}';
    final team = result['Constructor']['name'] as String;

    final positionColor = position == 1
        ? F1Colors.yellow
        : position == 2
        ? F1Colors.lightGrey
        : F1Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              'P$position',
              style: TextStyle(
                color: positionColor,
                fontWeight: FontWeight.bold,
                fontSize: position == 1 ? 18 : 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driverName,
                  style: TextStyle(
                    color: F1Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: position == 1 ? 16 : 14,
                  ),
                ),
                Text(
                  team,
                  style: TextStyle(color: F1Colors.lightGrey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
