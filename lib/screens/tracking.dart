import 'package:flutter/material.dart';

import 'home_screen.dart';

class tracking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [AnimatedPositioned(
          duration: Duration(seconds: 2), // Animation duration
          curve: Curves.easeInOut, // Smooth movement
          top: -250,
          left: 0,
          right: 0,
          bottom: 0,
          child: Image.asset(
            'assets/map3.jpg',
            fit: BoxFit.contain,
          ),
        ),

          /// **Back Button**
          Positioned(
            top: 30,
            left: 20,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.black.withOpacity(0.8),
              onPressed: () { Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );},
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),

          /// **Bottom Card**
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(top: 15.0 , bottom: 30.0 , right: 15.0 , left: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// **Pickup Status**
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Your Pickup in Real Time",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),

                  /// **Estimated Time**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time, color: Colors.green, size: 18),
                      SizedBox(width: 5),
                      Text("30 minutes", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 10),

                  /// **Status Message**
                  Text(
                    "Our team is on the way! Watch their journey, get updates, and be ready for a smooth pickup. 🚚",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
