import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Service> services = [
      Service(name: 'Professional Installation', icon: Icons.build, description: 'Expert installation of your custom parts'),
      Service(name: 'Performance Tuning', icon: Icons.speed, description: 'Optimize your vehicle\'s performance'),
      Service(name: 'Detailing', icon: Icons.cleaning_services, description: 'Premium detailing services for your ride'),
      Service(name: 'Diagnostic Check', icon: Icons.report, description: 'Comprehensive vehicle health check'),
      Service(name: 'Paint Job', icon: Icons.format_paint, description: 'Custom paint jobs and wraps'),
      Service(name: 'Audio System Installation', icon: Icons.speaker, description: 'High-end audio system setup'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Services', style: TextStyle(color: Colors.orange)),
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(services[index].icon, color: Colors.black),
              ),
              title: Text(services[index].name, style: const TextStyle(color: Colors.white)),
              subtitle: Text(services[index].description, style: const TextStyle(color: Colors.white70)),
              trailing: ElevatedButton(
                onPressed: () {
                  // Implement booking logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Booked ${services[index].name}')),
                  );
                },
                child: const Text('Book'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Service {
  final String name;
  final IconData icon;
  final String description;

  const Service({required this.name, required this.icon, required this.description});
}
