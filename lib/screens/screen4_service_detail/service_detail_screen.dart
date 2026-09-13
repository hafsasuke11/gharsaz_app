import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/service_model.dart';

import '../../providers/professionals_provider.dart';

import '../../widgets/professional_card.dart';

class ServiceDetailScreen
    extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailScreen({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    final professionalsProvider =
    context.watch<
        ProfessionalsProvider>();

    final filteredProfessionals =
    professionalsProvider
        .professionals
        .where(
          (professional) {
        return professional
            .service
            .trim()
            .toLowerCase() ==
            service.name
                .trim()
                .toLowerCase();
      },
    )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          service.name,

          style: TextStyle(
            color: isDark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .start,

          children: [
            Center(
              child: Image.network(
                service.image,
                height: 140,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            Text(
              service.name,

              style: TextStyle(
                fontSize: 32,

                fontWeight:
                FontWeight.bold,

                color: isDark
                    ? Colors.white
                    : Colors.black,
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            Text(
              service.description,

              style: TextStyle(
                fontSize: 16,

                color: isDark
                    ? Colors.white70
                    : Colors.grey,
              ),
            ),

            const SizedBox(
              height: 35,
            ),

            Text(
              'Available Professionals',

              style: TextStyle(
                fontSize: 24,

                fontWeight:
                FontWeight.bold,

                color: isDark
                    ? Colors.white
                    : Colors.black,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Expanded(
              child:
              professionalsProvider
                  .isLoading
                  ? const Center(
                child:
                CircularProgressIndicator(),
              )
                  : filteredProfessionals
                  .isEmpty
                  ? Center(
                child: Text(
                  'No professionals available',

                  style:
                  TextStyle(
                    color: isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount:
                filteredProfessionals
                    .length,

                itemBuilder:
                    (
                    context,
                    index,
                    ) {
                  final professional =
                  filteredProfessionals[
                  index];

                  return ProfessionalCard(
                    professional:
                    professional,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}