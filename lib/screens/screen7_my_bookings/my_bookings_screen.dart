import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../providers/booking_provider.dart';

import '../../widgets/side_drawer.dart';

class MyBookingsScreen
    extends StatefulWidget {
  const MyBookingsScreen({
    super.key,
  });

  @override
  State<MyBookingsScreen> createState() =>
      _MyBookingsScreenState();
}

class _MyBookingsScreenState
    extends State<MyBookingsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<BookingProvider>().fetchBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
    context.watch<BookingProvider>();

    final bookings = bookingProvider
        .bookings
        .where(
          (booking) =>
      booking.status !=
          'Cancelled',
    )
        .toList();

    return Scaffold(
      drawer: const SideDrawer(),

      appBar: AppBar(
        title: const Text(
          'My Bookings',
        ),

        centerTitle: true,
      ),

      body: bookingProvider.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : bookings.isEmpty
          ? const Center(
        child: Text(
          'No active bookings',
        ),
      )
          : ListView.builder(
        padding:
        const EdgeInsets.all(
          20,
        ),

        itemCount:
        bookings.length,

        itemBuilder:
            (context, index) {
          final booking =
          bookings[index];

          return Container(
            margin:
            const EdgeInsets.only(
              bottom: 20,
            ),

            padding:
            const EdgeInsets.all(
              20,
            ),

            decoration:
            BoxDecoration(
              color: Theme.of(
                  context)
                  .cardColor,

              borderRadius:
              BorderRadius.circular(
                28,
              ),
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        booking
                            .professionalName,

                        style:
                        const TextStyle(
                          fontSize:
                          24,

                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),
                    ),

                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal:
                        16,

                        vertical:
                        8,
                      ),

                      decoration:
                      BoxDecoration(
                        color: booking
                            .status ==
                            'Pending'
                            ? Colors
                            .orange
                            : Colors
                            .green,

                        borderRadius:
                        BorderRadius.circular(
                          18,
                        ),
                      ),

                      child: Text(
                        booking
                            .status,

                        style:
                        const TextStyle(
                          color: Colors
                              .white,

                          fontWeight:
                          FontWeight
                              .w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    const Icon(
                      Icons
                          .location_on,

                      color: Colors
                          .green,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child: Text(
                        booking
                            .address,

                        style:
                        const TextStyle(
                          fontSize:
                          16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                Row(
                  children: [
                    const Icon(
                      Icons
                          .access_time,

                      color: Colors
                          .green,

                      size: 20,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Text(
                      DateFormat(
                        'dd MMM yyyy • hh:mm a',
                      ).format(
                        booking
                            .createdAt,
                      ),

                      style:
                      TextStyle(
                        color:
                        Colors.grey[
                        400],

                        fontSize:
                        14,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 26,
                ),

                SizedBox(
                  width: double
                      .infinity,

                  child:
                  ElevatedButton(
                    onPressed:
                        () async {
                      await bookingProvider
                          .cancelBooking(
                        booking.id,
                      );
                    },

                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      Colors
                          .red,

                      padding:
                      const EdgeInsets.symmetric(
                        vertical:
                        14,
                      ),

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          18,
                        ),
                      ),
                    ),

                    child:
                    const Text(
                      'Cancel Booking',

                      style:
                      TextStyle(
                        fontSize:
                        16,

                        fontWeight:
                        FontWeight
                            .w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}