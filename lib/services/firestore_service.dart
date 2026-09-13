import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  CollectionReference get servicesCollection =>
      firestore.collection('services');

  CollectionReference get bookingsCollection =>
      firestore.collection('bookings');

  CollectionReference get professionalsCollection =>
      firestore.collection('professionals');
}