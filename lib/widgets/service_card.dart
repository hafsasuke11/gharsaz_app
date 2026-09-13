import 'package:flutter/material.dart';

import '../models/service_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;

  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.service,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(
            28,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withValues(
                alpha: 0.08,
              ),

              blurRadius: 10,

              offset: const Offset(
                0,
                4,
              ),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [
            Expanded(
              child: Center(
                child: Image.network(
                  service.image,

                  fit: BoxFit.contain,

                  errorBuilder:
                      (
                      context,
                      error,
                      stackTrace,
                      ) {
                    return const Icon(
                      Icons
                          .home_repair_service,

                      size: 70,

                      color: Colors.green,
                    );
                  },
                ),
              ),
            ),

            const SizedBox(
              height: 14,
            ),

            Text(
              service.name,

              textAlign:
              TextAlign.center,

              maxLines: 2,

              overflow:
              TextOverflow.ellipsis,

              style: const TextStyle(
                color: Colors.black,

                fontSize: 20,

                fontWeight:
                FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}