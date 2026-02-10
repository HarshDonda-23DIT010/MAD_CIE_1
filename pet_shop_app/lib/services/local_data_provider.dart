import '../models/product.dart';
import '../models/pet_category.dart';
import '../models/pet_service.dart';

/// Local data provider that supplies all pet shop data without requiring Firebase.
/// This data is also used to seed Firestore when Firebase is connected.
class LocalDataProvider {
  // ─── Products ───
  static List<Product> getAllProducts() {
    return _products;
  }

  static List<Product> getTrendingProducts() {
    return _products.where((p) => p.isTrending).toList();
  }

  static List<Product> getProductsByPetType(String petType) {
    return _products.where((p) => p.petType == petType).toList();
  }

  static List<Product> getProductsByCategory(String category) {
    return _products.where((p) => p.category == category).toList();
  }

  static Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<Product> searchProducts(String query) {
    final q = query.toLowerCase();
    return _products
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.description.toLowerCase().contains(q))
        .toList();
  }

  // ─── Categories ───
  static List<PetCategory> getAllCategories() {
    return _categories;
  }

  static List<PetCategory> getCategoriesByPetType(String petType) {
    return _categories.where((c) => c.petType == petType).toList();
  }

  // ─── Services ───
  static List<PetService> getAllServices() {
    return _services;
  }

  static List<PetService> getServicesByPetType(String petType) {
    return _services.where((s) => s.petType == petType).toList();
  }

  // ════════════════════════════════════════════
  // DATA
  // ════════════════════════════════════════════

  static final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'Royal Canin Adult Dog Food',
      description: 'Premium nutrition for adult dogs with balanced vitamins and minerals for healthy growth.',
      price: 1299.0,
      imageUrl: 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=400',
      category: 'Dog Food',
      petType: 'Dog',
      rating: 4.5,
      reviewCount: 234,
      weight: '3kg',
      composition: 'Chicken, Rice, Corn, Wheat Gluten, Animal Fats, Vegetable Fibres',
      isTrending: true,
    ),
    Product(
      id: 'p2',
      name: 'Pedigree Chicken & Vegetables',
      description: 'Complete dog food with real chicken and vegetables for strong bones and teeth.',
      price: 599.0,
      imageUrl: 'https://images.unsplash.com/photo-1568640347023-a616a30bc3bd?w=400',
      category: 'Dog Food',
      petType: 'Dog',
      rating: 4.0,
      reviewCount: 189,
      weight: '1.2kg',
      composition: 'Chicken, Rice, Vegetables, Minerals, Vitamins',
      isTrending: true,
    ),
    Product(
      id: 'p3',
      name: 'Drools Puppy Starter',
      description: 'Specially formulated nutrition for puppies with DHA for brain development.',
      price: 449.0,
      imageUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=400',
      category: 'Dog Food',
      petType: 'Dog',
      rating: 4.2,
      reviewCount: 156,
      weight: '1.5kg',
      composition: 'Chicken, Egg, Rice, Fish Oil, DHA, Omega-3',
      isTrending: false,
    ),
    Product(
      id: 'p4',
      name: 'Dog Chew Bones Pack',
      description: 'Natural dog chew bones that help clean teeth and keep your dog entertained.',
      price: 349.0,
      imageUrl: 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=400',
      category: 'Dog Treats',
      petType: 'Dog',
      rating: 4.3,
      reviewCount: 98,
      weight: '500g',
      composition: 'Natural Rawhide, Calcium, Protein',
      isTrending: true,
    ),
    Product(
      id: 'p5',
      name: 'Purepet Chicken Flavour Biscuit',
      description: 'Delicious chicken flavoured biscuits for dogs as a healthy snack reward.',
      price: 199.0,
      imageUrl: 'https://images.unsplash.com/photo-1623387641168-d9803dbd3f6b?w=400',
      category: 'Dog Treats',
      petType: 'Dog',
      rating: 3.9,
      reviewCount: 67,
      weight: '400g',
      composition: 'Wheat Flour, Chicken Meal, Sugar, Fat',
      isTrending: false,
    ),
    Product(
      id: 'p6',
      name: 'Anti-Tick Dog Shampoo',
      description: 'Medicated shampoo that removes ticks and fleas while keeping the coat shiny.',
      price: 299.0,
      imageUrl: 'https://images.unsplash.com/photo-1583337130417-13104dec14c3?w=400',
      category: 'Dog Treatment',
      petType: 'Dog',
      rating: 4.1,
      reviewCount: 145,
      weight: '250ml',
      composition: 'Neem Extract, Tea Tree Oil, Aloe Vera',
      isTrending: true,
    ),
    Product(
      id: 'p7',
      name: 'Dog Grooming Brush',
      description: 'Professional grade slicker brush for removing tangles and loose fur.',
      price: 499.0,
      imageUrl: 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=400',
      category: 'Dog Grooming',
      petType: 'Dog',
      rating: 4.4,
      reviewCount: 87,
      weight: '200g',
      composition: 'Stainless Steel Pins, Ergonomic Handle',
      isTrending: false,
    ),
    Product(
      id: 'p8',
      name: 'Whiskas Cat Food Tuna',
      description: 'Premium tuna flavoured cat food with essential nutrients for indoor cats.',
      price: 799.0,
      imageUrl: 'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=400',
      category: 'Cat Food',
      petType: 'Cat',
      rating: 4.3,
      reviewCount: 312,
      weight: '1.2kg',
      composition: 'Tuna, Rice, Corn, Chicken Meal, Vitamins',
      isTrending: true,
    ),
    Product(
      id: 'p9',
      name: 'Me-O Kitten Food',
      description: 'Complete and balanced kitten food with calcium for strong bones.',
      price: 399.0,
      imageUrl: 'https://images.unsplash.com/photo-1526336024174-e58f5cdd8e13?w=400',
      category: 'Cat Food',
      petType: 'Cat',
      rating: 4.0,
      reviewCount: 178,
      weight: '900g',
      composition: 'Fish, Rice, Chicken, Taurine, Calcium',
      isTrending: false,
    ),
    Product(
      id: 'p10',
      name: 'Cat Scratching Post',
      description: 'Durable sisal scratching post with dangling toy to keep cats active.',
      price: 1499.0,
      imageUrl: 'https://images.unsplash.com/photo-1545249390-6bdfa286032f?w=400',
      category: 'Cat Accessories',
      petType: 'Cat',
      rating: 4.6,
      reviewCount: 56,
      weight: '2.5kg',
      composition: 'Sisal Rope, MDF Wood, Plush Fabric',
      isTrending: true,
    ),
    Product(
      id: 'p11',
      name: 'Bird Seed Premium Mix',
      description: 'High quality mixed bird seed with sunflower, millet and safflower.',
      price: 349.0,
      imageUrl: 'https://images.unsplash.com/photo-1522926193341-e9ffd686c60f?w=400',
      category: 'Bird Food',
      petType: 'Bird',
      rating: 4.2,
      reviewCount: 89,
      weight: '1kg',
      composition: 'Sunflower Seeds, Millet, Safflower, Canary Seed',
      isTrending: false,
    ),
    Product(
      id: 'p12',
      name: 'Bird Cage Deluxe',
      description: 'Spacious bird cage with multiple perches and feeding bowls included.',
      price: 2499.0,
      imageUrl: 'https://images.unsplash.com/photo-1520808663317-647b476a81b9?w=400',
      category: 'Bird Accessories',
      petType: 'Bird',
      rating: 4.5,
      reviewCount: 34,
      weight: '4kg',
      composition: 'Powder-coated Steel, Wooden Perches',
      isTrending: true,
    ),
    Product(
      id: 'p13',
      name: 'Fish Tank Filter',
      description: 'High-performance aquarium filter with 3-stage filtration for clean water.',
      price: 899.0,
      imageUrl: 'https://images.unsplash.com/photo-1520301255226-bf5f144451c1?w=400',
      category: 'Fish Accessories',
      petType: 'Fish',
      rating: 4.1,
      reviewCount: 123,
      weight: '600g',
      composition: 'Mechanical, Chemical, Biological Filtration',
      isTrending: false,
    ),
    Product(
      id: 'p14',
      name: 'Eco-Friendly Dog Toys Set',
      description: 'Set of 5 eco-friendly chew toys made from natural rubber and cotton.',
      price: 699.0,
      imageUrl: 'https://images.unsplash.com/photo-1535294435445-d7249b8f0d8c?w=400',
      category: 'Dog Treats',
      petType: 'Dog',
      rating: 4.7,
      reviewCount: 213,
      weight: '350g',
      composition: 'Natural Rubber, Organic Cotton, Non-toxic Dye',
      isTrending: true,
    ),
    Product(
      id: 'p15',
      name: 'Puppy Training Pads 50-Pack',
      description: 'Super absorbent training pads for housebreaking puppies with leak-proof base.',
      price: 549.0,
      imageUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=400',
      category: 'Dog Accessories',
      petType: 'Dog',
      rating: 4.0,
      reviewCount: 98,
      weight: '1.2kg',
      composition: '5-Layer Protection, Quilted Surface',
      isTrending: false,
    ),
  ];

  static final List<PetCategory> _categories = [
    PetCategory(id: 'c1', name: 'Dog Food', imageUrl: 'https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=300', petType: 'Dog'),
    PetCategory(id: 'c2', name: 'Dog Treats', imageUrl: 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=300', petType: 'Dog'),
    PetCategory(id: 'c3', name: 'Dog Treatment', imageUrl: 'https://images.unsplash.com/photo-1583337130417-13104dec14c3?w=300', petType: 'Dog'),
    PetCategory(id: 'c4', name: 'Dog Grooming', imageUrl: 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=300', petType: 'Dog'),
    PetCategory(id: 'c5', name: 'Dog Accessories', imageUrl: 'https://images.unsplash.com/photo-1535294435445-d7249b8f0d8c?w=300', petType: 'Dog'),
    PetCategory(id: 'c6', name: 'Cat Food', imageUrl: 'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=300', petType: 'Cat'),
    PetCategory(id: 'c7', name: 'Cat Accessories', imageUrl: 'https://images.unsplash.com/photo-1545249390-6bdfa286032f?w=300', petType: 'Cat'),
    PetCategory(id: 'c8', name: 'Bird Food', imageUrl: 'https://images.unsplash.com/photo-1522926193341-e9ffd686c60f?w=300', petType: 'Bird'),
    PetCategory(id: 'c9', name: 'Bird Accessories', imageUrl: 'https://images.unsplash.com/photo-1520808663317-647b476a81b9?w=300', petType: 'Bird'),
    PetCategory(id: 'c10', name: 'Fish Accessories', imageUrl: 'https://images.unsplash.com/photo-1520301255226-bf5f144451c1?w=300', petType: 'Fish'),
  ];

  static final List<PetService> _services = [
    PetService(id: 's1', name: 'Bathing & Drying', description: 'Complete bathing service with premium shampoo and blow drying.', imageUrl: 'https://images.unsplash.com/photo-1581888227599-779811939961?w=300', price: 499.0, petType: 'Dog'),
    PetService(id: 's2', name: 'Dog Sitting', description: 'Professional pet sitting service at our comfortable facility.', imageUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=300', price: 799.0, petType: 'Dog'),
    PetService(id: 's3', name: 'Hair Styling', description: 'Expert hair styling and trimming by certified groomers.', imageUrl: 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=300', price: 699.0, petType: 'Dog'),
    PetService(id: 's4', name: 'Teeth Cleaning', description: 'Professional dental cleaning to keep your pet\'s teeth healthy.', imageUrl: 'https://images.unsplash.com/photo-1583337130417-13104dec14c3?w=300', price: 599.0, petType: 'Dog'),
    PetService(id: 's5', name: 'Nail Trimming', description: 'Safe and gentle nail trimming service for your pet.', imageUrl: 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=300', price: 299.0, petType: 'Dog'),
    PetService(id: 's6', name: 'Flea Treatment', description: 'Effective flea and tick removal treatment with preventive care.', imageUrl: 'https://images.unsplash.com/photo-1535294435445-d7249b8f0d8c?w=300', price: 899.0, petType: 'Dog'),
    PetService(id: 's7', name: 'Dental Hygiene Service', description: 'Complete oral care including cleaning and breath freshening.', imageUrl: 'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=300', price: 749.0, petType: 'Cat'),
    PetService(id: 's8', name: 'Paw Care Services', description: 'Paw pad moisturizing and nail care for healthier paws.', imageUrl: 'https://images.unsplash.com/photo-1526336024174-e58f5cdd8e13?w=300', price: 399.0, petType: 'Cat'),
    PetService(id: 's9', name: 'Flea Control Solutions', description: 'Professional flea control and prevention treatment.', imageUrl: 'https://images.unsplash.com/photo-1545249390-6bdfa286032f?w=300', price: 849.0, petType: 'Cat'),
  ];
}
