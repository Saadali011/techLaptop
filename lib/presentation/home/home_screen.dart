import 'package:flutter/material.dart';
import '../../components/product_card.dart';
import '../../data/demo_data.dart';
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
  final FocusNode _searchFocusNode = FocusNode();

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

  void _updateProduct(Product updatedProduct) {
    setState(() {
      final index = _filteredProducts.indexWhere((p) =>
      p.id == updatedProduct.id);
      if (index != -1) {
        _filteredProducts[index] = updatedProduct;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Add focus change listener
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        // Close keyboard when focus is lost
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Unfocus the search field when tapping outside
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: HomeHeader(
                    onSearchChanged: _handleSearchChanged,
                    focusNode: _searchFocusNode,
                  ),
                ),
              ),
              if (_searchQuery.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SectionTitle(title: "Search Results"),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(15.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.72,
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return ProductCard(
                          product: _filteredProducts[index],
                          onPress: () async {
                            final updatedProduct = await Navigator.pushNamed(
                              context,
                              DetailsScreen.routeName,
                              arguments: ProductDetailsArguments(
                                product: _filteredProducts[index],
                                onUpdate: _updateProduct,
                              ),
                            ) as Product?; // Cast the result as Product
                            if (updatedProduct != null) {
                              _updateProduct(updatedProduct); // Handle updated product
                            }
                          },
                        );
                      },
                      childCount: _filteredProducts.length,
                    ),
                  ),
                ),
              ] else ...[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      DiscountBanner(),
                      Categories(),
                      PopularBrands(),
                      SizedBox(height: 20),
                      PopularProducts(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
