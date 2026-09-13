import 'package:flutter/material.dart';

import '../models/service_model.dart';

import '../services/firestore_service.dart';

class ServicesProvider
    extends ChangeNotifier {
  final FirestoreService firestoreService =
  FirestoreService();

  List<ServiceModel> services = [];

  List<ServiceModel> filteredServices =
  [];

  bool isLoading = false;

  String selectedCategory = 'All';

  Future<void> fetchServices() async {
    isLoading = true;

    notifyListeners();

    try {
      final snapshot = await firestoreService
          .servicesCollection
          .get();

      services = snapshot.docs.map((doc) {
        return ServiceModel.fromFirestore(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();

      filteredServices = services;
    } catch (e) {
      debugPrint('Failed to fetch services: $e');
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  bool _sameCategory(
      String a,
      String b,
      ) {
    return a.trim().toLowerCase() ==
        b.trim().toLowerCase();
  }

  void filterByCategory(
      String category,
      ) {
    selectedCategory = category;

    if (category == 'All') {
      filteredServices = services;
    } else {
      filteredServices = services.where((
          service,
          ) {
        return _sameCategory(
          service.category,
          category,
        );
      }).toList();
    }

    notifyListeners();
  }

  void searchServices(String query) {
    List<ServiceModel> tempServices =
    selectedCategory == 'All'
        ? services
        : services.where((service) {
      return _sameCategory(
          service.category,
          selectedCategory,
      );
    }).toList();

    if (query.isEmpty) {
      filteredServices = tempServices;
    } else {
      filteredServices =
          tempServices.where((service) {
            return service.name
                .toLowerCase()
                .contains(
              query.toLowerCase(),
            );
          }).toList();
    }

    notifyListeners();
  }
}