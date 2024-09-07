import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  @override
  void initState() {
    super.initState();
    _loadSearchQuery();  // Load search query from SharedPreferences
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadSearchQuery() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchQuery = prefs.getString('searchQuery') ?? '';
      _filteredProducts = demoProducts.where((product) {
        final productTitle = product.title.toLowerCase();
        final productBrand = product.brandName.toLowerCase();
        final searchLowerCase = _searchQuery.toLowerCase();
        return productTitle.contains(searchLowerCase) ||
            productBrand.contains(searchLowerCase);
      }).toList();
    });
  }

  Future<void> _saveSearchQuery(String query) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('searchQuery', query);
  }

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
    _saveSearchQuery(query);  // Save search query to SharedPreferences
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
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
                            ) as Product?;
                            if (updatedProduct != null) {
                              _updateProduct(updatedProduct);
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
