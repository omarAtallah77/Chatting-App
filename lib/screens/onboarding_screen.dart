import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.black,
      pages: [
        PageViewModel(
          title: "Welcome to Social Chat App",
          body: "Connect with people in real-time, send messages, and share photos.",
          image: Center(child: Image.asset("assets/Chat App logo.png", height: 175.0)),
          decoration: PageDecoration(
            pageColor: Colors.black,  // Full black background for all pages
            titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.amber),  // Amber title
            bodyTextStyle: TextStyle(fontSize: 18.0, color: Colors.amber),  // Amber body text
          ),
        ),
        PageViewModel(
          title: "Instant Messaging",
          body: "Send messages instantly with our real-time database.",
          image: Center(child: Image.asset("assets/Chat App logo.png", height: 175.0)),
          decoration: PageDecoration(
            pageColor: Colors.black,  // Black background for this screen as well
            titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.amber),  // Amber title
            bodyTextStyle: TextStyle(fontSize: 18.0, color: Colors.amber),  // Amber body text
          ),
        ),
      ],
      onDone: () {
        // On done go to the home screen
        Navigator.of(context).pushReplacementNamed('/signin');
      },
      onSkip: () {
        // On skip also go to the home screen
        Navigator.of(context).pushReplacementNamed('/signin');
      },
      showSkipButton: true,
      skip: const Text("Skip", style: TextStyle(color: Colors.amber)),  // Amber skip button
      next: const Icon(Icons.arrow_forward, color: Colors.amber),  // Amber next icon
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.amber)),  // Amber done button
      dotsDecorator: DotsDecorator(
        activeColor: Colors.amber,  // Amber active dot color
        color: Colors.grey,  // Inactive dot color
      ),
    );
  }
}
