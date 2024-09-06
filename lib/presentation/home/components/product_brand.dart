import 'package:flutter/material.dart';
import '../../../data/demo_data.dart';
import '../../../models/Product.dart';
import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularBrandCard extends StatelessWidget {
  const PopularBrandCard({
    Key? key,
    required this.category,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 150,
          height: 90,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  width: 200,
                  // fit: BoxFit.cover,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PopularBrands extends StatelessWidget {
  const PopularBrands({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Popular Brands",
            // press: () {
            //   Navigator.pushNamed(context, ProductsScreen.routeName);
            // },
          ),
        ),
        SizedBox(height: 7,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: demoProducts.map((product) {
              return PopularBrandCard(
                image: product.images.isNotEmpty ? product.images[0] : "", // Use the first image
                category: product.brandName, // Use the brand name
                press: () {
                  Navigator.pushNamed(context, ProductsScreen.routeName);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}