import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../models/home_data_model.dart';
import '../../services/api_service.dart';
import '../../widgets/custom_banner.dart';
import '../../widgets/category_card.dart';
import '../../widgets/product_card.dart';
import 'category_screen.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.jpg', height: 40),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.store, color: AppColors.whiteColor, size: 50),
                   SizedBox(height: 10),
                   Text(AppStrings.appName, style: TextStyle(color: AppColors.whiteColor, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: AppColors.secondaryColor),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
             // Note: Categories in drawer will be static or fetched? 
             // For now we can fetch them in FutureBuilder and pass here, or make Drawer simple.
             // We will keep simple link for now as categories are dynamic in body
          ],
        ),
      ),
      body: FutureBuilder<HomeData>(
        future: _apiService.fetchHomeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          final data = snapshot.data!;
          // Using data from API
          final bannerImages = data.banners;
          final categories = data.categories;
          final trendingProducts = data.trending;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Banner
                CustomBanner(imageUrls: bannerImages),
                
                const SizedBox(height: 24),

                // Trending Items
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        AppStrings.trendingItems,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(onPressed: (){}, child: const Text("View All"))
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: trendingProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: trendingProducts[index], 
                        onTap: () {
                             Navigator.push(
                             context,
                             MaterialPageRoute(builder: (_) => ProductDetailScreen(product: trendingProducts[index])),
                           );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),
                
                // Category Sections with Products
                ...categories.map((category) => Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                    children: [
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              category.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                  Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (_) => CategoryScreen(category: category)),
                                  );
                              }, 
                              child: const Text("View All")
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                       // Fetch products for this category using FutureBuilder
                       FutureBuilder<List<Product>>(
                         future: _apiService.fetchProductsByCategory(category.id),
                         builder: (context, productSnapshot) {
                           if (!productSnapshot.hasData) return const Center(child: CircularProgressIndicator());
                           final products = productSnapshot.data!;
                           
                           return SizedBox(
                            height: 220,
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              scrollDirection: Axis.horizontal,
                              itemCount: products.length > 5 ? 5 : products.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  product: products[index], 
                                  onTap: () {
                                       Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (_) => ProductDetailScreen(product: products[index])),
                                     );
                                  },
                                );
                              },
                            ),
                          );
                         }
                       ),
                    ],
                  ),
                )),
                
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
