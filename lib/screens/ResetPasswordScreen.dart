import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _message = '';

  // Method to search for a user by email
  Future<bool> searchUserByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Users')
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty; // Return true if user exists
    } catch (e) {
      print('Error searching user: $e');
      return false; // Return false in case of an error
    }
  }

  Future<void> _resetPassword() async {
    String email = _emailController.text.trim();

    // Check if the user exists
    bool userExists = await searchUserByEmail(email);

    if (userExists) {
      try {
        await _auth.sendPasswordResetEmail(email: email);
        setState(() {
          _message = 'Password reset link sent! Check your email.';
          _emailController.clear();
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          _message = e.message ?? 'An error occurred';
          _emailController.clear();
        });
      }
    } else {
      setState(() {
        _message = 'Invalid User.'; // Set message if user doesn't exist
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'Reset Password',
          style: TextStyle(color: Colors.amber),
        ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.amber), // Back icon
              onPressed: () => Navigator.of(context).pushReplacementNamed('/signin') )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
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
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                textStyle: TextStyle(color: Colors.white60),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Send Reset Link',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 25),
            Text(
              _message,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
