import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productName;
  final double price;
  final String imageAsset;

  const ProductDetailsScreen({
    Key? key,
    required this.productName,
    required this.price,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName, style: GoogleFonts.raleway(color: Colors.orange[300], fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageAsset,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: GoogleFonts.poppins(color: Colors.orange[300], fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Product Description',
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This is a high-quality ${productName.toLowerCase()} designed to enhance your vehicle\'s performance and appearance. Made with premium materials, it offers durability and style.',
                    style: GoogleFonts.roboto(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Features',
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  _buildFeatureItem('Premium quality materials'),
                  _buildFeatureItem('Easy installation'),
                  _buildFeatureItem('Enhances vehicle performance'),
                  _buildFeatureItem('Stylish design'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Added to cart: $productName')),
            );
          },
          child: Text('Add to Cart'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.orange[300], size: 20),
          SizedBox(width: 8),
          Text(
            feature,
            style: GoogleFonts.roboto(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}