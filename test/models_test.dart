import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gharsaz_app/models/booking_model.dart';
import 'package:gharsaz_app/models/service_model.dart';
import 'package:gharsaz_app/services/auth_service.dart';

void main() {
  group('AuthService.toE164', () {
    test('converts a local Pakistani number to E.164', () {
      expect(AuthService.toE164('03001234567'), '+923001234567');
    });

    test('leaves an already-E.164 number unchanged', () {
      expect(AuthService.toE164('+923001234567'), '+923001234567');
    });

    test('adds the country code when no leading zero is present', () {
      expect(AuthService.toE164('3001234567'), '+923001234567');
    });

    test('trims surrounding whitespace', () {
      expect(AuthService.toE164('  03001234567  '), '+923001234567');
    });
  });

  group('ServiceModel.fromFirestore', () {
    test('reads all fields from data map', () {
      final service = ServiceModel.fromFirestore({
        'name': 'AC Repair',
        'description': 'Fix your AC',
        'image': 'ac.png',
        'category': 'Cooling',
      }, 'service-1');

      expect(service.id, 'service-1');
      expect(service.name, 'AC Repair');
      expect(service.description, 'Fix your AC');
      expect(service.image, 'ac.png');
      expect(service.category, 'Cooling');
    });

    test('defaults missing fields to empty strings', () {
      final service = ServiceModel.fromFirestore({}, 'service-2');

      expect(service.id, 'service-2');
      expect(service.name, '');
      expect(service.description, '');
      expect(service.image, '');
      expect(service.category, '');
    });
  });

  group('BookingModel', () {
    test('fromFirestore parses a Timestamp createdAt', () {
      final createdAt = DateTime(2026, 1, 15, 10, 30);
      final booking = BookingModel.fromFirestore({
        'serviceName': 'Plumbing',
        'professionalName': 'Ali',
        'address': '123 Main St',
        'issue': 'Leaky pipe',
        'status': 'Confirmed',
        'createdAt': Timestamp.fromDate(createdAt),
      }, 'booking-1');

      expect(booking.id, 'booking-1');
      expect(booking.serviceName, 'Plumbing');
      expect(booking.status, 'Confirmed');
      expect(booking.createdAt, createdAt);
    });

    test('fromFirestore defaults status to Pending when missing', () {
      final booking = BookingModel.fromFirestore({
        'createdAt': Timestamp.now(),
      }, 'booking-2');

      expect(booking.status, 'Pending');
      expect(booking.serviceName, '');
    });

    test('toMap round-trips through fromFirestore', () {
      final original = BookingModel(
        id: 'booking-3',
        serviceName: 'Electrical',
        professionalName: 'Bilal',
        address: '456 Second St',
        issue: 'Flickering lights',
        status: 'Pending',
        createdAt: DateTime(2026, 3, 1, 9),
      );

      final roundTripped = BookingModel.fromFirestore(
        original.toMap(),
        original.id,
      );

      expect(roundTripped.serviceName, original.serviceName);
      expect(roundTripped.professionalName, original.professionalName);
      expect(roundTripped.address, original.address);
      expect(roundTripped.issue, original.issue);
      expect(roundTripped.status, original.status);
      expect(roundTripped.createdAt, original.createdAt);
    });
  });
}
