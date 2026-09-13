import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/services_provider.dart';

import '../../widgets/service_card.dart';
import '../../widgets/shimmer_service_card.dart';
import '../../widgets/side_drawer.dart';

import '../../utils/page_transition.dart';

import '../screen4_service_detail/service_detail_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final servicesProvider =
    context.watch<ServicesProvider>();

    final services =
    servicesProvider
        .filteredServices
        .where(
          (service) =>
      service.name
          .trim()
          .isNotEmpty,
    )
        .toList();

    return Scaffold(
      drawer: const SideDrawer(),

      appBar: AppBar(
        title: const Text(
          'Explore Services',
        ),

        centerTitle: true,
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(
          20,
        ),

        child:
        servicesProvider.isLoading
            ? GridView.builder(
          itemCount: 4,

          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
            MediaQuery.of(
                context)
                .size
                .width >
                900
                ? 4
                : 2,

            crossAxisSpacing:
            18,

            mainAxisSpacing:
            18,

            childAspectRatio:
            1.05,
          ),

          itemBuilder: (
              context,
              index,
              ) {
            return const ShimmerServiceCard();
          },
        )
            : services.isEmpty
            ? const Center(
          child: Text(
            'No services available',
          ),
        )
            : GridView.builder(
          itemCount:
          services.length,

          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
            MediaQuery.of(
                context)
                .size
                .width >
                900
                ? 4
                : 2,

            crossAxisSpacing:
            18,

            mainAxisSpacing:
            18,

            childAspectRatio:
            1.05,
          ),

          itemBuilder: (
              context,
              index,
              ) {
            final service =
            services[index];

            return ServiceCard(
              service: service,

              onTap: () {
                Navigator.push(
                  context,

                  PageTransition.slide(
                    ServiceDetailScreen(
                      service:
                      service,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}