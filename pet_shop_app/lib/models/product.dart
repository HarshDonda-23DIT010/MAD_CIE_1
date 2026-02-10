import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final String petType;
  final double rating;
  final int reviewCount;
  final String weight;
  final String composition;
  final bool isTrending;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.petType,
    this.rating = 4.0,
    this.reviewCount = 0,
    this.weight = '',
    this.composition = '',
    this.isTrending = false,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      petType: data['petType'] ?? '',
      rating: (data['rating'] ?? 4.0).toDouble(),
      reviewCount: data['reviewCount'] ?? 0,
      weight: data['weight'] ?? '',
      composition: data['composition'] ?? '',
      isTrending: data['isTrending'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'petType': petType,
      'rating': rating,
      'reviewCount': reviewCount,
      'weight': weight,
      'composition': composition,
      'isTrending': isTrending,
    };
  }
}