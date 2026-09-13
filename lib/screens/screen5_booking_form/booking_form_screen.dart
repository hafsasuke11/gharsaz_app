import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/professional_model.dart';

import '../../providers/booking_provider.dart';

class BookingFormScreen
    extends StatefulWidget {
  final ProfessionalModel
  professional;

  const BookingFormScreen({
    super.key,
    required this.professional,
  });

  @override
  State<BookingFormScreen>
  createState() =>
      _BookingFormScreenState();
}

class _BookingFormScreenState
    extends State<BookingFormScreen> {
  final TextEditingController
  addressController =
  TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    addressController.dispose();

    super.dispose();
  }

  Future<void> submitBooking() async {
    final professional =
        widget.professional;

    final bookingProvider =
    context.read<BookingProvider>();

    if (addressController.text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(
          context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter address',
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await bookingProvider
          .addBooking(
        professionalName:
        professional.name,

        address:
        addressController
            .text
            .trim(),

        status: 'Pending',
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
          context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Booking placed successfully',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
          context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }

    if (!mounted) {
      return;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final professional =
        widget.professional;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Service',
        ),

        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment
              .start,

          children: [
            const SizedBox(
              height: 20,
            ),

            Text(
              professional.name,

              style:
              const TextStyle(
                fontSize: 34,

                fontWeight:
                FontWeight.bold,

                color:
                Colors.black,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              professional.service,

              style:
              const TextStyle(
                fontSize: 18,

                color:
                Colors.grey,
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            TextField(
              controller:
              addressController,

              maxLines: 3,

              decoration:
              InputDecoration(
                hintText:
                'Enter your address',

                filled: true,

                fillColor:
                Theme.of(context)
                    .cardColor,

                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                    22,
                  ),

                  borderSide:
                  BorderSide.none,
                ),
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            SizedBox(
              width: double.infinity,

              height: 58,

              child:
              ElevatedButton(
                onPressed:
                isLoading
                    ? null
                    : submitBooking,

                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.green,

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                      20,
                    ),
                  ),
                ),

                child: isLoading
                    ? const SizedBox(
                  height: 24,

                  width: 24,

                  child:
                  CircularProgressIndicator(
                    color:
                    Colors.white,

                    strokeWidth:
                    2.5,
                  ),
                )
                    : const Text(
                  'Confirm Booking',

                  style:
                  TextStyle(
                    fontSize:
                    18,

                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}