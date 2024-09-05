import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main image view
        SizedBox(
          width: double.infinity, // Use full width
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              widget.product.images[selectedImage],
              // fit: BoxFit.cover,
              width: 80,
              height: 50,
            ),
          ),
        ),
        // const SizedBox(height: 20), // Space between image and thumbnail row
        // Thumbnail row
        Container(
          height: 50, // Set a fixed height to avoid overflow
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                widget.product.images.length,
                    (index) => SmallProductImage(
                  isSelected: index == selectedImage,
                  press: () {
                    setState(() {
                      selectedImage = index;
                    });
                  },
                  image: widget.product.images[index],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SmallProductImage extends StatefulWidget {
  const SmallProductImage({
    Key? key,
    required this.isSelected,
    required this.press,
    required this.image,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback press;
  final String image;

  @override
  State<SmallProductImage> createState() => _SmallProductImageState();
}

class _SmallProductImageState extends State<SmallProductImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(4), // Reduced padding
        height: 60, // Increased height to better fit the thumbnail
        width: 60, // Increased width to better fit the thumbnail
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(widget.isSelected ? 1 : 0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8), // Added border radius for better appearance
          child: Image.asset(
            widget.image,
            width: 80,
            height: 50,
            // fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
