import 'package:cloud_firestore/cloud_firestore.dart';

class PetCategory {
  final String id;
  final String name;
  final String imageUrl;
  final String petType;

  PetCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.petType,
  });

  factory PetCategory.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PetCategory(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      petType: data['petType'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'petType': petType,
    };
  }
}
