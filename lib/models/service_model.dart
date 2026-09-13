class ServiceModel {
  final String id;

  final String name;

  final String description;

  final String image;

  final String category;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
  });

  factory ServiceModel.fromFirestore(
      Map<String, dynamic> data,
      String id,
      ) {
    return ServiceModel(
      id: id,

      name: data['name'] ?? '',

      description:
      data['description'] ?? '',

      image: data['image'] ?? '',

      category:
      data['category'] ?? '',
    );
  }
}