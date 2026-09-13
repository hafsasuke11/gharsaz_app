import 'package:flutter/material.dart';

import '../models/professional_model.dart';

import '../services/firestore_service.dart';

class ProfessionalsProvider
    extends ChangeNotifier {
  final FirestoreService firestoreService =
  FirestoreService();

  List<ProfessionalModel> professionals = [];

  bool isLoading = false;

  Future<void> fetchProfessionals() async {
    isLoading = true;

    notifyListeners();

    final snapshot = await firestoreService
        .professionalsCollection
        .get();

    professionals = snapshot.docs.map((doc) {
      return ProfessionalModel.fromFirestore(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
    }).toList();

    isLoading = false;

    notifyListeners();
  }
}