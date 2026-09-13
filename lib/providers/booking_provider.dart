import 'package:flutter/material.dart';

import '../models/booking_model.dart';

import '../services/firestore_service.dart';

class BookingProvider
    extends ChangeNotifier {
  final FirestoreService firestoreService =
  FirestoreService();

  List<BookingModel> bookings = [];

  bool isLoading = false;

  Future<void> fetchBookings() async {
    isLoading = true;

    notifyListeners();

    final snapshot = await firestoreService
        .bookingsCollection
        .get();

    bookings = snapshot.docs.map((doc) {
      return BookingModel.fromFirestore(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
    }).toList();

    isLoading = false;

    notifyListeners();
  }

  Future<void> addBooking({
    required String professionalName,
    required String address,
    required String status,
  }) async {
    final bookingRef =
    firestoreService
        .bookingsCollection
        .doc();

    final bookingId = bookingRef.id;

    await bookingRef.set({
      'professionalName':
      professionalName,

      'address': address,

      'status': status,

      'createdAt':
      DateTime.now(),
    });

    await fetchBookings();

    // AUTO STATUS UPDATE
    Future.delayed(
      const Duration(minutes: 5),
          () async {
        final bookingDoc =
        await firestoreService
            .bookingsCollection
            .doc(bookingId)
            .get();

        if (!bookingDoc.exists) {
          return;
        }

        final data =
        bookingDoc.data()
        as Map<String, dynamic>?;

        if (data == null) {
          return;
        }

        if (data['status'] !=
            'Cancelled') {
          await firestoreService
              .bookingsCollection
              .doc(bookingId)
              .update({
            'status': 'On The Way',
          });

          fetchBookings();
        }
      },
    );
  }

  Future<void> cancelBooking(
      String bookingId,
      ) async {
    await firestoreService
        .bookingsCollection
        .doc(bookingId)
        .update({
      'status': 'Cancelled',
    });

    await fetchBookings();
  }
}