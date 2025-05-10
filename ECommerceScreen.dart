import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ECommerceScreen extends StatelessWidget {
  const ECommerceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop', style: GoogleFonts.raleway(color: Colors.orange[300], fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.orange[300]),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Cart functionality coming soon!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryFilter(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildProductCard(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search products...',
          hintStyle: GoogleFonts.poppins(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.orange[300]),
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    List<String> categories = ['All', 'Wheels', 'Performance', 'Engine Parts', 'Exterior'];
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: index == 0, // Always select 'All' for this example
              onSelected: (selected) {
                // Implement category selection logic here
              },
              backgroundColor: Colors.grey[800],
              selectedColor: Colors.orange[300],
              labelStyle: GoogleFonts.poppins(
                color: index == 0 ? Colors.black : Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, int index) {
    final List<String> categories = ['Wheels', 'Performance', 'Engine Parts', 'Exterior'];
    final List<double> prices = [249.95, 299.94, 349.93, 399.92];
    final category = categories[index % categories.length];
    final price = prices[index % prices.length];

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product_details',
          arguments: {
            'productName': category,
            'price': price,
            'imageAsset': 'assets/images/product_${index + 1}.jpg',
          },
        );
      },
      child: Card(
        color: Colors.grey[900],
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    'assets/images/product_${index + 1}.jpg',
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: IconButton(
                      icon: Icon(Icons.favorite_border, color: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added to favorites!')),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: GoogleFonts.poppins(color: Colors.orange[300], fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Premium Quality',
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: GoogleFonts.roboto(color: Colors.orange[300], fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added to cart!')),
                          );
                        },
                        child: Text('Add', style: GoogleFonts.poppins(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.orange[300],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}