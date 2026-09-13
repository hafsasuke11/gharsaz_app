import 'package:flutter/material.dart';

import '../models/professional_model.dart';

import '../screens/screen5_booking_form/booking_form_screen.dart';

import '../utils/page_transition.dart';

class ProfessionalCard extends StatelessWidget {
  final ProfessionalModel professional;

  const ProfessionalCard({
    super.key,
    required this.professional,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,

        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withValues(alpha: 0.03),

            blurRadius: 10,
          ),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 38,

            backgroundImage:
            professional.image.isEmpty
                ? null
                : NetworkImage(professional.image),

            onBackgroundImageError:
            professional.image.isEmpty
                ? null
                : (exception, stackTrace) {},

            child: professional.image.isEmpty
                ? const Icon(Icons.person, size: 38)
                : null,
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  professional.name,

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 18,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      professional.rating
                          .toString(),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  '${professional.experience} years experience',
                ),

                const SizedBox(height: 8),

                Text(
                  professional.city,
                ),
              ],
            ),
          ),

          Column(
            children: [
              Text(
                'Rs ${professional.price}',

                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,

                    PageTransition.slide(
                      BookingFormScreen(
                        professional:
                        professional,
                      ),
                    ),
                  );
                },

                child: const Text('Book'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}