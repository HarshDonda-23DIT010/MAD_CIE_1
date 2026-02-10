import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../utils/constants.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  bool _showProductDetail = false;
  bool _showComposition = false;

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFav = favoritesProvider.isFavorite(widget.product.id);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22),
                  ),
                  IconButton(
                    onPressed: () => favoritesProvider.toggleFavorite(widget.product),
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? AppColors.red : AppColors.grey,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Center(
                      child: Hero(
                        tag: 'product_${widget.product.id}',
                        child: CachedNetworkImage(
                          imageUrl: widget.product.imageUrl,
                          height: 250,
                          width: 250,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 250,
                            width: 250,
                            color: AppColors.lightGrey,
                            child: const Center(
                              child: CircularProgressIndicator(color: AppColors.primary),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 250,
                            width: 250,
                            color: AppColors.lightGrey,
                            child: const Icon(Icons.pets, size: 80, color: AppColors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Product Info
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.product.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (widget.product.weight.isNotEmpty)
                                  Text(
                                    widget.product.weight,
                                    style: AppTextStyles.caption,
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            '₹${widget.product.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Rating
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          RatingBarIndicator(
                            rating: widget.product.rating,
                            itemBuilder: (context, _) =>
                                const Icon(Icons.star, color: AppColors.starYellow),
                            itemCount: 5,
                            itemSize: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${widget.product.reviewCount} reviews)',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        widget.product.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Quantity Selector
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          _buildQuantityButton(
                            Icons.remove,
                            () {
                              if (_quantity > 1) setState(() => _quantity--);
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$_quantity',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          _buildQuantityButton(
                            Icons.add,
                            () => setState(() => _quantity++),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Divider
                    const Divider(height: 1, indent: 24, endIndent: 24),

                    // Product Detail Expandable
                    _buildExpandableSection(
                      'Product Detail',
                      widget.product.description,
                      _showProductDetail,
                      () => setState(() => _showProductDetail = !_showProductDetail),
                    ),

                    const Divider(height: 1, indent: 24, endIndent: 24),

                    // Composition Expandable
                    _buildExpandableSection(
                      'Composition',
                      widget.product.composition.isNotEmpty
                          ? widget.product.composition
                          : 'No composition information available.',
                      _showComposition,
                      () => setState(() => _showComposition = !_showComposition),
                    ),

                    const Divider(height: 1, indent: 24, endIndent: 24),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              final cart = Provider.of<CartProvider>(context, listen: false);
              for (int i = 0; i < _quantity; i++) {
                cart.addToCart(widget.product);
              }
              // Reset quantity after adding if already existed
              if (_quantity > 1) {
                final item = cart.items.where((e) => e.product.id == widget.product.id).first;
                item.quantity = _quantity;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${widget.product.name} added to cart!'),
                  backgroundColor: AppColors.primary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              'ADD TO CART',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: AppColors.primary),
      ),
    );
  }

  Widget _buildExpandableSection(
      String title, String content, bool isExpanded, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.subheading),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_right,
                  color: AppColors.grey,
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 8),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.grey,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
