import 'package:flutter/material.dart';
import '../../components/product_card.dart';
import '../../models/Product.dart';
import '../details/details_screen.dart';
import 'components/categories.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';
import 'components/popular_product.dart';
import 'components/product_brand.dart';
import 'components/section_title.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _filteredProducts = demoProducts;
  String _searchQuery = '';

  void _handleSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProducts = demoProducts.where((product) {
        final productTitle = product.title.toLowerCase();
        final productBrand = product.brandName.toLowerCase();
        final searchLowerCase = query.toLowerCase();
        return productTitle.contains(searchLowerCase) ||
            productBrand.contains(searchLowerCase);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _searchQuery.isNotEmpty
            ? _buildSearchResults() // Show search results
            : _buildDefaultContent(), // Show default content
      ),
    );
  }

  Widget _buildDefaultContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          HomeHeader(onSearchChanged: _handleSearchChanged),
          DiscountBanner(),
          Categories(),
          PopularBrands(),
          SizedBox(height: 20),
          PopularProducts(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(title: "Search Results"),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: _filteredProducts[index],
                onPress: () => Navigator.pushNamed(
                  context,
                  DetailsScreen.routeName,
                  arguments: ProductDetailsArguments(product: _filteredProducts[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
