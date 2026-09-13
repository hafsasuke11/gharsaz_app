import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;

  final String serviceName;

  final String professionalName;

  final String address;

  final String issue;

  final String status;

  final DateTime createdAt;

  BookingModel({
    required this.id,
    required this.serviceName,
    required this.professionalName,
    required this.address,
    required this.issue,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'serviceName': serviceName,

      'professionalName':
      professionalName,

      'address': address,

      'issue': issue,

      'status': status,

      'createdAt':
      Timestamp.fromDate(
        createdAt,
      ),
    };
  }

  factory BookingModel.fromFirestore(
      Map<String, dynamic> data,
      String documentId,
      ) {
    return BookingModel(
      id: documentId,

      serviceName:
      data['serviceName'] ?? '',

      professionalName:
      data['professionalName'] ??
          '',

      address:
      data['address'] ?? '',

      issue: data['issue'] ?? '',

      status:
      data['status'] ??
          'Pending',

      createdAt: data['createdAt'] is Timestamp
          ? (data['createdAt']
      as Timestamp)
          .toDate()
          : DateTime.parse(
        data['createdAt']
            ?.toString() ??
            DateTime.now()
                .toIso8601String(),
      ),
    );
  }
}