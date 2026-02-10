import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pet_category.dart';
import '../services/local_data_provider.dart';
import '../utils/constants.dart';
import 'product_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedPetType = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _petFilters = [
    {'name': 'All', 'icon': Icons.apps},
    {'name': 'Dog', 'icon': Icons.pets},
    {'name': 'Cat', 'icon': Icons.pets},
    {'name': 'Bird', 'icon': Icons.flutter_dash},
    {'name': 'Fish', 'icon': Icons.water},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Explore Categories',
                style: AppTextStyles.heading,
              ),
            ),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildPetTypeFilters(),
            const SizedBox(height: 16),
            Expanded(child: _buildCategoriesGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Product or Brand',
            hintStyle: const TextStyle(color: AppColors.grey, fontSize: 15),
            prefixIcon: const Icon(Icons.search, color: AppColors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildPetTypeFilters() {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _petFilters.length,
        itemBuilder: (context, index) {
          final filter = _petFilters[index];
          final isSelected = _selectedPetType == filter['name'];
          return GestureDetector(
            onTap: () => setState(() => _selectedPetType = filter['name'] as String),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.lightGrey,
                ),
              ),
              child: Text(
                filter['name'] as String,
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    final List<PetCategory> categories;
    if (_selectedPetType == 'All') {
      categories = LocalDataProvider.getAllCategories();
    } else {
      categories = LocalDataProvider.getCategoriesByPetType(_selectedPetType);
    }

    if (categories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.category_outlined, size: 60, color: AppColors.grey),
            const SizedBox(height: 16),
            Text(
              'No categories found',
              style: AppTextStyles.subheading.copyWith(color: AppColors.grey),
            ),
          ],
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) => _buildCategoryCard(categories[index]),
    );
  }

  Widget _buildCategoryCard(PetCategory category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductsScreen(
              categoryName: category.name,
              petType: category.petType,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: category.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.lightGrey,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.lightGrey,
                    child: const Icon(Icons.pets, size: 40, color: AppColors.grey),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                category.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Category Products Sub-screen ───
class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;
  final String petType;

  const CategoryProductsScreen({
    super.key,
    required this.categoryName,
    required this.petType,
  });

  @override
  Widget build(BuildContext context) {
    final products = LocalDataProvider.getProductsByCategory(categoryName);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inventory_2_outlined, size: 60, color: AppColors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No products in this category',
                    style: AppTextStyles.subheading.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(product: product),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                        child: CachedNetworkImage(
                          imageUrl: product.imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(
                            width: 100,
                            height: 100,
                            color: AppColors.lightGrey,
                            child: const Icon(Icons.pets, color: AppColors.grey),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(product.description, style: AppTextStyles.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 8),
                              Text(
                                '₹${product.price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
