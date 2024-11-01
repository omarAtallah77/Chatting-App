import 'package:flutter/material.dart';
class UserTile extends StatelessWidget {


  final String text ;
  final void Function() ? onTap;


  const UserTile ({
    super.key ,
    required this.text ,
    required this.onTap
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white24, Colors.white10],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(2, 3), // Adds a slight shadow effect
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withOpacity(0.3),
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: 26,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.amber,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
