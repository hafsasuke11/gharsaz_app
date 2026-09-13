import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerServiceCard
    extends StatelessWidget {
  const ShimmerServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:
      Theme.of(context).cardColor,

      highlightColor:
      Colors.white.withValues(alpha: 0.2),

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(28),
        ),
      ),
    );
  }
}