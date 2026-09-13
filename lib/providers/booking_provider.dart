import 'package:firebase_auth/firebase_auth.dart';
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

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        bookings = [];
        return;
      }

      final snapshot = await firestoreService
          .bookingsCollection
          .where('userId', isEqualTo: userId)
          .get();

      bookings = snapshot.docs.map((doc) {
        return BookingModel.fromFirestore(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    } catch (e) {
      debugPrint('Failed to fetch bookings: $e');
    } finally {
      isLoading = false;

      notifyListeners();
    }
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
      'userId':
      FirebaseAuth.instance.currentUser?.uid,

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
        try {
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
        } catch (e) {
          debugPrint('Auto status update failed: $e');
        }
      },
    );
  }

  Future<bool> cancelBooking(
      String bookingId,
      ) async {
    try {
      await firestoreService
          .bookingsCollection
          .doc(bookingId)
          .update({
        'status': 'Cancelled',
      });

      await fetchBookings();

      return true;
    } catch (e) {
      debugPrint('Failed to cancel booking: $e');

      return false;
    }
  }
}