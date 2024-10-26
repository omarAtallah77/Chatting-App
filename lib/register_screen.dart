import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Register", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First Name input field
                _buildTextField(_firstNameController, "First Name"),
                SizedBox(height: 20),

                // Last Name input field
                _buildTextField(_lastNameController, "Last Name"),
                SizedBox(height: 20),

                // Email input field
                _buildTextField(_emailController, "Email"),
                SizedBox(height: 20),

                // Password input field
                _buildTextField(_passwordController, "Password", isPassword: true),
                SizedBox(height: 20),

                // Confirm Password input field
                _buildTextField(_confirmPasswordController, "Confirm Password", isPassword: true),
                SizedBox(height: 20),

                // Phone input field
                _buildTextField(_phoneController, "Phone", keyboardType: TextInputType.phone),
                SizedBox(height: 20),

                // Register button
                ElevatedButton(
                  onPressed: () => _register(context), // Call the register method
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),

                // Link to Sign In
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/signin');
                  },
                  child: Text("Already have an account? Sign in here", style: TextStyle(color: Colors.amber)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to build text fields
  Widget _buildTextField(TextEditingController controller, String label, {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white60),
        filled: true,
        fillColor: Colors.grey[800],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),
      obscureText: isPassword,
      style: TextStyle(color: Colors.white),
    );
  }

  // Method to handle registration
  void _register(BuildContext context) async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String phone = _phoneController.text.trim();

    // Check if passwords match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    // Attempt registration
    User? user = await AuthService().registerWithEmailAndPassword(
      firstName,
      lastName,
      email,
      password,
      phone,
    );

    if (user != null) {
      // Registration successful, navigate to the home screen
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      // Handle error (show a message to the user)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Please try again.')),
      );
    }
  }
}