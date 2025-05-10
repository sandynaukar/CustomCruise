import 'package:flutter/material.dart';

class CustomizationScreen extends StatefulWidget {
  const CustomizationScreen({Key? key}) : super(key: key);

  @override
  _CustomizationScreenState createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
  final Map<String, String> _selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize Your Ride', style: TextStyle(color: Colors.orange)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCustomizationCard('Body Kit', ['Sporty', 'Elegant', 'Aggressive', 'Classic', 'Futuristic']),
          _buildCustomizationCard('Exterior Color', ['Midnight Black', 'Pearl White', 'Racing Red', 'Electric Blue', 'Sunset Orange', 'Forest Green']),
          _buildCustomizationCard('Interior Theme', ['Modern', 'Vintage', 'Luxury', 'Minimalist', 'Tech-inspired']),
          _buildCustomizationCard('Wheels', ['18" Alloy', '19" Sport', '20" Premium', '21" Forged', '22" Custom']),
          _buildCustomizationCard('Performance Upgrade', ['Engine Tuning', 'Suspension Kit', 'Brake System', 'Exhaust System', 'Turbocharger']),
          _buildCustomizationCard('Lighting', ['LED Headlights', 'Ambient Interior', 'Underglow Kit', 'Custom Tail Lights']),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/ar_preview', arguments: _selectedOptions),
            child: const Text('Preview Customization (AR)'),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomizationCard(String title, List<String> options) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.orange)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options.map((option) => ChoiceChip(
                label: Text(option),
                selected: _selectedOptions[title] == option,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _selectedOptions[title] = option;
                    } else {
                      _selectedOptions.remove(title);
                    }
                  });
                },
                selectedColor: Colors.orange,
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}