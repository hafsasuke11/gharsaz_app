class ProfessionalModel {
  final String id;

  final String name;

  final String service;

  final String city;

  final int experience;

  final double rating;

  final int price;

  final String image;

  ProfessionalModel({
    required this.id,
    required this.name,
    required this.service,
    required this.city,
    required this.experience,
    required this.rating,
    required this.price,
    required this.image,
  });

  factory ProfessionalModel.fromFirestore(
      Map<String, dynamic> data,
      String id,
      ) {
    return ProfessionalModel(
      id: id,

      name: data['name'] ?? '',

      // supports BOTH service & profession
      service:
      data['service'] ??
          data['profession'] ??
          '',

      city: data['city'] ?? '',

      experience:
      int.tryParse(
        data['experience']
            .toString(),
      ) ??
          0,

      rating:
      double.tryParse(
        data['rating']
            .toString(),
      ) ??
          0,

      price:
      int.tryParse(
        data['price']
            .toString(),
      ) ??
          0,

      image:
      data['image'] ?? '',
    );
  }
}