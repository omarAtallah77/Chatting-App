import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    getCurrentUser() ;

  }


   String? email;

   String? phoneNumber;

   String ?firstName;

   String ?lastName;



   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.green),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green[200],
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                "$firstName $lastName",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 5),
              Text(email ?? "email ", style: TextStyle(fontSize: 16, color: Colors.black54)),
              Text(phoneNumber ?? "phone number", style: TextStyle(fontSize: 16, color: Colors.black54)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _signOut(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text("Sign Out", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getCurrentUser() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      if (mounted) {
        setState(() {
          email = user.email; // Get email from FirebaseAuth
        });
      }

      await _firestore.collection('users').doc(user.uid).get().then((doc) {
        if (doc.exists) {
          if (mounted) {
            setState(() {
              firstName = doc.data()?['firstName'];
              lastName = doc.data()?['lastName'];
              phoneNumber = doc.data()?['phone'];
            });
          }
        }
      });
    }
  }
}

