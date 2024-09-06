import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isExpanded = false;

  void _toggleFavorite() {
    setState(() {
      widget.product.toggleFavourite(); // Toggle favorite status
    });
    // You might want to notify listeners or update global state here
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.product.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _toggleFavorite,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: 48,
                  decoration: BoxDecoration(
                    color: widget.product.isFavourite
                        ? const Color(0xFFFFE6E6)
                        : const Color(0xFFF5F6F9),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/Heart Icon_2.svg",
                    colorFilter: ColorFilter.mode(
                        widget.product.isFavourite
                            ? const Color(0xFFFF4848)
                            : const Color(0xFFDBDEE4),
                        BlendMode.srcIn),
                    height: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.description,
                maxLines: _isExpanded ? null : 3,
                overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      _isExpanded ? "Show Less" : "See More Detail",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      _isExpanded ? Icons.arrow_upward : Icons.arrow_forward_ios,
                      size: 12,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
