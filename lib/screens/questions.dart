import 'package:flutter/material.dart';
import 'package:untitled/screens/chat_screen_2.dart';
import 'home_screen.dart';

class questions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home'); // Use pop instead of pushReplacement
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'FAQ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              faqItem(
                question: "How can you convert leftovers to soil?",
                answer: "By collecting food wastes and composting it to soil",
              ),
              faqItem(
                question: "Is it organic soil?",
                answer: "Yes, it’s totally organic",
              ),
              faqItem(
                question: "Does the silicone bag make food leak?",
                answer: "No, it’s eco-friendly and also tight, so it won’t leak any food",
              ),
              faqItem(
                question: "How can we get in touch with you?",
                answer: "Through our second cycle application",
              ),
              faqItem(
                question: "What’s the duration of the car arrival to my location?",
                answer: "1 hour maximum",
              ),
              SizedBox(height: 40.0),
              Column(
                children: [
                  Image.asset(
                    'assets/question_icon.png',
                    fit: BoxFit.cover,
                    width: 60.0,
                    height: 60.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Still have questions?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatScreen_2(receiverEmail: 'Customer Service', receiverID: ''),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Ask us",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create a FAQ item widget
  Widget faqItem({required String question, required String answer}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.green[50],
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
        ),
        iconColor: Colors.green,
        collapsedIconColor: Colors.green,
        title: Text(
          question,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          ListTile(
            title: Text(answer),
          ),
        ],
      ),
    );
  }
}
