import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants.dart';
import '../models/Product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRatio = 1.02,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRatio;
  final Product product;
  final VoidCallback onPress;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late Product product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
    _initializeFavoriteStatus();
  }

  Future<void> _initializeFavoriteStatus() async {
    bool isFavorite = await product.isFavourite; // Ensure this method returns a Future<bool>
    setState(() {
      product = product.copyWith(isFavourite: isFavorite);
    });
  }

  void _toggleFavorite() async {
    await product.toggleFavourite();
    _initializeFavoriteStatus(); // Update the favorite status after toggling
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: GestureDetector(
        onTap: widget.onPress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: widget.aspectRatio,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(product.images[0]),
              ),
            ),
            SizedBox(
              height: 40,
              child: Text(
                product.title,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                FavoriteIcon(
                  isFavourite: product.isFavourite,
                  onTap: _toggleFavorite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  final bool isFavourite;
  final VoidCallback onTap;

  const FavoriteIcon({
    Key? key,
    required this.isFavourite,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: isFavourite
              ? kPrimaryColor.withOpacity(0.15)
              : kSecondaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          "assets/icons/Heart Icon_2.svg",
          colorFilter: ColorFilter.mode(
            isFavourite ? const Color(0xFFFF4848) : const Color(0xFFDBDEE4),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
