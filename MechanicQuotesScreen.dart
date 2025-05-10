import 'package:flutter/material.dart';

class MechanicQuotesScreen extends StatelessWidget {
  final Map<String, String> customizations;

  const MechanicQuotesScreen({Key? key, required this.customizations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data for mechanic quotes
    final List<Map<String, dynamic>> mechanicQuotes = [
      {'name': 'John\'s Auto Shop', 'price': '\$2,500', 'rating': 4.5},
      {'name': 'Quick Fix Garage', 'price': '\$2,200', 'rating': 4.2},
      {'name': 'Custom Kings', 'price': '\$2,800', 'rating': 4.8},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mechanic Quotes', style: TextStyle(color: Colors.orange)),
      ),
      body: ListView.builder(
        itemCount: mechanicQuotes.length,
        itemBuilder: (context, index) {
          final quote = mechanicQuotes[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(quote['name'] as String, style: const TextStyle(color: Colors.orange)),
              subtitle: Text('Rating: ${quote['rating']}'),
              trailing: Text(quote['price'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () => _showMechanicDetails(context, quote),
            ),
          );
        },
      ),
    );
  }

  void _showMechanicDetails(BuildContext context, Map<String, dynamic> mechanic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(mechanic['name'] as String, style: const TextStyle(color: Colors.orange)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price: ${mechanic['price']}'),
              Text('Rating: ${mechanic['rating']}'),
              const SizedBox(height: 16),
              const Text('Customizations:'),
              ...customizations.entries.map((e) => Text('${e.key}: ${e.value}')),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Select Mechanic'),
              onPressed: () {
                // Implement mechanic selection logic
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You selected ${mechanic['name']}!')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}