import 'package:flutter/material.dart';

class MechanicRegistrationScreen extends StatefulWidget {
  const MechanicRegistrationScreen({Key? key}) : super(key: key);

  @override
  _MechanicRegistrationScreenState createState() => _MechanicRegistrationScreenState();
}

class _MechanicRegistrationScreenState extends State<MechanicRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mapsLinkController = TextEditingController();

  @override
  void dispose() {
    _shopNameController.dispose();
    _ownerNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _mapsLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanic Registration', style: TextStyle(color: Colors.orange)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Join Our Network of Expert Mechanics',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.orange),
                ),
                SizedBox(height: 16),
                Text(
                  'Fill in your details to register as a mechanic on CustomCruise.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                ),
                SizedBox(height: 24),
                _buildTextFormField(
                  controller: _shopNameController,
                  labelText: 'Shop Name',
                  icon: Icons.store,
                ),
                _buildTextFormField(
                  controller: _ownerNameController,
                  labelText: 'Owner Name',
                  icon: Icons.person,
                ),
                _buildTextFormField(
                  controller: _addressController,
                  labelText: 'Address',
                  icon: Icons.location_on,
                ),
                _buildTextFormField(
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                _buildTextFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                _buildTextFormField(
                  controller: _mapsLinkController,
                  labelText: 'Google Maps Link',
                  icon: Icons.map,
                  keyboardType: TextInputType.url,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Register as Mechanic'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: Colors.orange),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange),
          ),
          filled: true,
          fillColor: Colors.grey[900],
        ),
        style: TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement mechanic registration logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration submitted successfully!')),
      );
      // Navigate back or to a confirmation screen
      Navigator.of(context).pop();
    }
  }
}