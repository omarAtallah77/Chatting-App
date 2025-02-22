import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Easily Sell\nYour Waste",
          body: "Sell your waste in designated places and earn rewards",
          image: Center(
            child: Image.asset("assets/onboarding_one.jpg", fit: BoxFit.fill, width: 600.0),
          ),
          decoration: PageDecoration(
            imageFlex: 2,
            bodyFlex: 1,
            pageColor: Colors.white,  // White background
            titleTextStyle: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold, color: Colors.green),
            bodyTextStyle: TextStyle(fontSize: 18.0, color: Colors.green),
          ),
        ),
        PageViewModel(
          title: "RECYCLE YOUR FOOD",
          body: "Don't throw away your leftover food! Recycle it into compost, animal feed, or donate it to those in need.",
          image: Center(
            child: Image.asset("assets/onboarding_two.jpg", fit: BoxFit.fill, width: 600.0),
          ),
          decoration: PageDecoration(
            imageFlex: 1,
            bodyFlex: 1,
            pageColor: Colors.white,  // White background
            titleTextStyle: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold, color: Colors.green),
            bodyTextStyle: TextStyle(fontSize: 18.0, color: Colors.green),
          ),
        )
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
      skip: const Text("Skip", style: TextStyle(color: Colors.green)),  // Amber skip button
      next: const Icon(Icons.arrow_forward, color: Colors.green),  // Amber next icon
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green)),  // Amber done button
      dotsDecorator: DotsDecorator(
        activeColor: Colors.green,  // Amber active dot color
        color: Colors.grey,  // Inactive dot color
      ),
    );
  }
}
