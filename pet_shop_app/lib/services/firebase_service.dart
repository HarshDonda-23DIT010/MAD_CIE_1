import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import '../models/pet_category.dart';
import '../models/pet_service.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ─── Products ───
  Stream<List<Product>> getProducts() {
    return _firestore.collection('products').snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList(),
        );
  }

  Stream<List<Product>> getTrendingProducts() {
    return _firestore
        .collection('products')
        .where('isTrending', isEqualTo: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList(),
        );
  }

  Stream<List<Product>> getProductsByPetType(String petType) {
    return _firestore
        .collection('products')
        .where('petType', isEqualTo: petType)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList(),
        );
  }

  Stream<List<Product>> getProductsByCategory(String category) {
    return _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList(),
        );
  }

  Future<Product?> getProductById(String id) async {
    final doc = await _firestore.collection('products').doc(id).get();
    if (doc.exists) return Product.fromFirestore(doc);
    return null;
  }

  // ─── Categories ───
  Stream<List<PetCategory>> getCategories() {
    return _firestore.collection('categories').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => PetCategory.fromFirestore(doc))
              .toList(),
        );
  }

  Stream<List<PetCategory>> getCategoriesByPetType(String petType) {
    return _firestore
        .collection('categories')
        .where('petType', isEqualTo: petType)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PetCategory.fromFirestore(doc))
              .toList(),
        );
  }

  // ─── Services ───
  Stream<List<PetService>> getServices() {
    return _firestore.collection('services').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => PetService.fromFirestore(doc))
              .toList(),
        );
  }

  Stream<List<PetService>> getServicesByPetType(String petType) {
    return _firestore
        .collection('services')
        .where('petType', isEqualTo: petType)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PetService.fromFirestore(doc))
              .toList(),
        );
  }

  // ─── Search ───
  Future<List<Product>> searchProducts(String query) async {
    final snapshot = await _firestore.collection('products').get();
    final allProducts =
        snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    return allProducts
        .where((p) =>
            p.name.toLowerCase().contains(query.toLowerCase()) ||
            p.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // ─── Seed Data ───
  Future<void> seedData() async {
    // Check if data already exists
    final productsSnapshot = await _firestore.collection('products').limit(1).get();
    if (productsSnapshot.docs.isNotEmpty) return;

    // Seed Products
    final products = [
      {
        'name': 'Royal Canin Adult Dog Food',
        'description': 'Premium nutrition for adult dogs with balanced vitamins and minerals for healthy growth.',
        'price': 1299.0,
        'imageUrl': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400',
        'category': 'Dog Food',
        'petType': 'Dog',
        'rating': 4.5,
        'reviewCount': 234,
        'weight': '3kg',
        'composition': 'Chicken, Rice, Corn, Wheat Gluten, Animal Fats, Vegetable Fibres',
        'isTrending': true,
      },
      {
        'name': 'Pedigree Chicken & Vegetables',
        'description': 'Complete dog food with real chicken and vegetables for strong bones and teeth.',
        'price': 599.0,
        'imageUrl': 'https://images.unsplash.com/photo-1568640347023-a616a30bc3bd?w=400',
        'category': 'Dog Food',
        'petType': 'Dog',
        'rating': 4.0,
        'reviewCount': 189,
        'weight': '1.2kg',
        'composition': 'Chicken, Rice, Vegetables, Minerals, Vitamins',
        'isTrending': true,
      },
      {
        'name': 'Drools Puppy Starter',
        'description': 'Specially formulated nutrition for puppies with DHA for brain development.',
        'price': 449.0,
        'imageUrl': 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=400',
        'category': 'Dog Food',
        'petType': 'Dog',
        'rating': 4.2,
        'reviewCount': 156,
        'weight': '1.5kg',
        'composition': 'Chicken, Egg, Rice, Fish Oil, DHA, Omega-3',
        'isTrending': false,
      },
      {
        'name': 'Dog Chew Bones Pack',
        'description': 'Natural dog chew bones that help clean teeth and keep your dog entertained.',
        'price': 349.0,
        'imageUrl': 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=400',
        'category': 'Dog Treats',
        'petType': 'Dog',
        'rating': 4.3,
        'reviewCount': 98,
        'weight': '500g',
        'composition': 'Natural Rawhide, Calcium, Protein',
        'isTrending': true,
      },
      {
        'name': 'Purepet Chicken Flavour Biscuit',
        'description': 'Delicious chicken flavoured biscuits for dogs as a healthy snack reward.',
        'price': 199.0,
        'imageUrl': 'https://images.unsplash.com/photo-1623387641168-d9803dbd3f6b?w=400',
        'category': 'Dog Treats',
        'petType': 'Dog',
        'rating': 3.9,
        'reviewCount': 67,
        'weight': '400g',
        'composition': 'Wheat Flour, Chicken Meal, Sugar, Fat',
        'isTrending': false,
      },
      {
        'name': 'Anti-Tick Dog Shampoo',
        'description': 'Medicated shampoo that removes ticks and fleas while keeping the coat shiny.',
        'price': 299.0,
        'imageUrl': 'https://images.unsplash.com/photo-1583337130417-13104dec14c3?w=400',
        'category': 'Dog Treatment',
        'petType': 'Dog',
        'rating': 4.1,
        'reviewCount': 145,
        'weight': '250ml',
        'composition': 'Neem Extract, Tea Tree Oil, Aloe Vera',
        'isTrending': true,
      },
      {
        'name': 'Dog Grooming Brush',
        'description': 'Professional grade slicker brush for removing tangles and loose fur.',
        'price': 499.0,
        'imageUrl': 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=400',
        'category': 'Dog Grooming',
        'petType': 'Dog',
        'rating': 4.4,
        'reviewCount': 87,
        'weight': '200g',
        'composition': 'Stainless Steel Pins, Ergonomic Handle',
        'isTrending': false,
      },
      {
        'name': 'Whiskas Cat Food Tuna',
        'description': 'Premium tuna flavoured cat food with essential nutrients for indoor cats.',
        'price': 799.0,
        'imageUrl': 'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=400',
        'category': 'Cat Food',
        'petType': 'Cat',
        'rating': 4.3,
        'reviewCount': 312,
        'weight': '1.2kg',
        'composition': 'Tuna, Rice, Corn, Chicken Meal, Vitamins',
        'isTrending': true,
      },
      {
        'name': 'Me-O Kitten Food',
        'description': 'Complete and balanced kitten food with calcium for strong bones.',
        'price': 399.0,
        'imageUrl': 'https://images.unsplash.com/photo-1526336024174-e58f5cdd8e13?w=400',
        'category': 'Cat Food',
        'petType': 'Cat',
        'rating': 4.0,
        'reviewCount': 178,
        'weight': '900g',
        'composition': 'Fish, Rice, Chicken, Taurine, Calcium',
        'isTrending': false,
      },
      {
        'name': 'Cat Scratching Post',
        'description': 'Durable sisal scratching post with dangling toy to keep cats active.',
        'price': 1499.0,
        'imageUrl': 'https://images.unsplash.com/photo-1545249390-6bdfa286032f?w=400',
        'category': 'Cat Accessories',
        'petType': 'Cat',
        'rating': 4.6,
        'reviewCount': 56,
        'weight': '2.5kg',
        'composition': 'Sisal Rope, MDF Wood, Plush Fabric',
        'isTrending': true,
      },
      {
        'name': 'Bird Seed Premium Mix',
        'description': 'High quality mixed bird seed with sunflower, millet and safflower.',
        'price': 349.0,
        'imageUrl': 'https://images.unsplash.com/photo-1522926193341-e9ffd686c60f?w=400',
        'category': 'Bird Food',
        'petType': 'Bird',
        'rating': 4.2,
        'reviewCount': 89,
        'weight': '1kg',
        'composition': 'Sunflower Seeds, Millet, Safflower, Canary Seed',
        'isTrending': false,
      },
      {
        'name': 'Bird Cage Deluxe',
        'description': 'Spacious bird cage with multiple perches and feeding bowls included.',
        'price': 2499.0,
        'imageUrl': 'https://images.unsplash.com/photo-1520808663317-647b476a81b9?w=400',
        'category': 'Bird Accessories',
        'petType': 'Bird',
        'rating': 4.5,
        'reviewCount': 34,
        'weight': '4kg',
        'composition': 'Powder-coated Steel, Wooden Perches',
        'isTrending': true,
      },
      {
        'name': 'Fish Tank Filter',
        'description': 'High-performance aquarium filter with 3-stage filtration for clean water.',
        'price': 899.0,
        'imageUrl': 'https://images.unsplash.com/photo-1520301255226-bf5f144451c1?w=400',
        'category': 'Fish Accessories',
        'petType': 'Fish',
        'rating': 4.1,
        'reviewCount': 123,
        'weight': '600g',
        'composition': 'Mechanical, Chemical, Biological Filtration',
        'isTrending': false,
      },
      {
        'name': 'Eco-Friendly Dog Toys Set',
        'description': 'Set of 5 eco-friendly chew toys made from natural rubber and cotton.',
        'price': 699.0,
        'imageUrl': 'https://images.unsplash.com/photo-1535294435445-d7249b8f0d8c?w=400',
        'category': 'Dog Treats',
        'petType': 'Dog',
        'rating': 4.7,
        'reviewCount': 213,
        'weight': '350g',
        'composition': 'Natural Rubber, Organic Cotton, Non-toxic Dye',
        'isTrending': true,
      },
      {
        'name': 'Puppy Training Pads 50-Pack',
        'description': 'Super absorbent training pads for housebreaking puppies with leak-proof base.',
        'price': 549.0,
        'imageUrl': 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=400',
        'category': 'Dog Accessories',
        'petType': 'Dog',
        'rating': 4.0,
        'reviewCount': 98,
        'weight': '1.2kg',
        'composition': '5-Layer Protection, Quilted Surface',
        'isTrending': false,
      },
    ];

    for (var product in products) {
      await _firestore.collection('products').add(product);
    }

    // Seed Categories
    final categories = [
      {'name': 'Dog Food', 'imageUrl': 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=300', 'petType': 'Dog'},
      {'name': 'Dog Treats', 'imageUrl': 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=300', 'petType': 'Dog'},
      {'name': 'Dog Treatment', 'imageUrl': 'https://images.unsplash.com/photo-1583337130417-13104dec14c3?w=300', 'petType': 'Dog'},
      {'name': 'Dog Grooming', 'imageUrl': 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=300', 'petType': 'Dog'},
      {'name': 'Dog Accessories', 'imageUrl': 'https://images.unsplash.com/photo-1535294435445-d7249b8f0d8c?w=300', 'petType': 'Dog'},
      {'name': 'Cat Food', 'imageUrl': 'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=300', 'petType': 'Cat'},
      {'name': 'Cat Accessories', 'imageUrl': 'https://images.unsplash.com/photo-1545249390-6bdfa286032f?w=300', 'petType': 'Cat'},
      {'name': 'Bird Food', 'imageUrl': 'https://images.unsplash.com/photo-1522926193341-e9ffd686c60f?w=300', 'petType': 'Bird'},
      {'name': 'Bird Accessories', 'imageUrl': 'https://images.unsplash.com/photo-1520808663317-647b476a81b9?w=300', 'petType': 'Bird'},
      {'name': 'Fish Accessories', 'imageUrl': 'https://images.unsplash.com/photo-1520301255226-bf5f144451c1?w=300', 'petType': 'Fish'},
    ];

    for (var category in categories) {
      await _firestore.collection('categories').add(category);
    }

    // Seed Services
    final services = [
      {
        'name': 'Bathing & Drying',
        'description': 'Complete bathing service with premium shampoo and blow drying.',
        'imageUrl': 'https://images.unsplash.com/photo-1581888227599-779811939961?w=300',
        'price': 499.0,
        'petType': 'Dog',
      },
      {
        'name': 'Dog Sitting',
        'description': 'Professional pet sitting service at our comfortable facility.',
        'imageUrl': 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=300',
        'price': 799.0,
        'petType': 'Dog',
      },
      {
        'name': 'Hair Styling',
        'description': 'Expert hair styling and trimming by certified groomers.',
        'imageUrl': 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=300',
        'price': 699.0,
        'petType': 'Dog',
      },
      {
        'name': 'Teeth Cleaning',
        'description': 'Professional dental cleaning to keep your pet\'s teeth healthy.',
        'imageUrl': 'https://images.unsplash.com/photo-1583337130417-13104dec14c3?w=300',
        'price': 599.0,
        'petType': 'Dog',
      },
      {
        'name': 'Nail Trimming',
        'description': 'Safe and gentle nail trimming service for your pet.',
        'imageUrl': 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=300',
        'price': 299.0,
        'petType': 'Dog',
      },
      {
        'name': 'Flea Treatment',
        'description': 'Effective flea and tick removal treatment with preventive care.',
        'imageUrl': 'https://images.unsplash.com/photo-1535294435445-d7249b8f0d8c?w=300',
        'price': 899.0,
        'petType': 'Dog',
      },
      {
        'name': 'Dental Hygiene Service',
        'description': 'Complete oral care including cleaning and breath freshening.',
        'imageUrl': 'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=300',
        'price': 749.0,
        'petType': 'Cat',
      },
      {
        'name': 'Paw Care Services',
        'description': 'Paw pad moisturizing and nail care for healthier paws.',
        'imageUrl': 'https://images.unsplash.com/photo-1526336024174-e58f5cdd8e13?w=300',
        'price': 399.0,
        'petType': 'Cat',
      },
      {
        'name': 'Flea Control Solutions',
        'description': 'Professional flea control and prevention treatment.',
        'imageUrl': 'https://images.unsplash.com/photo-1545249390-6bdfa286032f?w=300',
        'price': 849.0,
        'petType': 'Cat',
      },
    ];

    for (var service in services) {
      await _firestore.collection('services').add(service);
    }
  }
}
