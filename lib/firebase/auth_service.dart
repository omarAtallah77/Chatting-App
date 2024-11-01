import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user
  Future<User?> registerWithEmailAndPassword(
      String firstName, String lastName, String email, String password, String phone) async {
    try {
      // Create a new user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password);
      User? user = userCredential.user;

      // save user info in a doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid ,
        'email': email ,

      },);

      // Check if user is created
      if (user != null) {
        // Store additional user information in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'firstName': firstName,
          'password': password,
          'lastName': lastName,
          'email': email,
          'phone': phone,
        });
      }

      return user;
    } catch (e) {
      // Print the error message for debugging
      print("Registration error: ${e.toString()}");
      return null; // Return null if there was an error
    }
  }

  // Login user
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in the user with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user; // Return the user


      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid ,
        'email': email
      },);

    } catch (e) {
      // Print the error message for debugging
      print("Login error: ${e.toString()}");
      return null; // Return null if there was an error
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

