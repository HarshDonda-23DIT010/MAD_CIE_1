import 'package:cloud_firestore/cloud_firestore.dart';

class PetService {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String petType;

  PetService({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.petType,
  });

  factory PetService.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PetService(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      petType: data['petType'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'petType': petType,
    };
  }
}
