import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/firebase/ChatService.dart';
import 'package:untitled/firebase/auth_service.dart';
import 'package:untitled/screens/about.dart';
import 'package:untitled/screens/questions.dart';
import 'package:untitled/screens/recycle_screen.dart';
import 'package:untitled/screens/tracking.dart';
import 'activitty.dart';
import 'chat_screen_2.dart';
import 'sign_in_screen.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _emailController = TextEditingController();

  //final ChatService _chatService = ChatService();
  //final AuthService _authService = AuthService();
  int _currentIndex = 0;



  @override
  void initState() {
    super.initState();
   Profile();
  }


  final List<Widget> _screens = [
    HomeContent(), // Home Page Content
    ActivityScreen(),
    RecycleScreen(),
    ChatScreen_2(receiverEmail: 'Customer Service', receiverID: '') ,
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.green[200],
        backgroundColor: Colors.green,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.list_alt_rounded, size: 30),
          Icon(Icons.recycling_outlined, size: 30),
          Icon(Icons.chat, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}


class _HomeContentState extends State<HomeContent> {

  @override
  void initState() {
    super.initState();
    getCurrentUser() ;

  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String ? userEmail ;
  String? firstName ;
  String? lastName ;

  void getCurrentUser() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      if (mounted) {
        setState(() {
          userEmail = user.email; // Get email from FirebaseAuth
        });
      }

      await _firestore.collection('users').doc(user.uid).get().then((doc) {
        if (doc.exists) {
          if (mounted) {
            setState(() {
              firstName = doc.data()?['firstName'];
              lastName = doc.data()?['lastName'];
            });
          }
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/home.jpg',
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.0),
              Container(
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(10.0),
                    left: Radius.circular(10.0),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40.0,
                      child: Image.asset(
                        'assets/logo1-removebg-preview.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('$firstName $lastName' ?? "Loading..."  ,
                          style: TextStyle(
                            color: Color.fromRGBO(15, 255, 80, 1.0),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$userEmail '?? "Loading...",
                          style: TextStyle(
                            color: Colors.lightGreen,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Center(
                child: Text(
                  'Selection',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              MenuButton(icon: Icons.recycling, text: "Go Recycle", color: Colors.lightGreen[100], iconColor: Colors.green , index: 1 ),
              MenuButton(icon: Icons.location_on, text: "Live Tracking", color: Colors.red[100], iconColor: Colors.red, index: 2),
              MenuButton(icon: Icons.shopping_cart_outlined, text: "Shopping", color: Colors.orange[100], iconColor: Colors.orange , index: 3 ,),
              Container(
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(20.0),
                    left: Radius.circular(20.0),
                  ),
                  color: Colors.purple[100],
                ),
                child: MaterialButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RecycleScreen(donate: true , title: "Donation",)),
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/donate-icon.png',
                        fit: BoxFit.cover,
                        width: 30.0,
                      ),
                      Expanded(
                        child: Center(

                          child: Text(
                            'Donation',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 15.0,),
              MenuButton(icon: Icons.messenger_outline_rounded, text: "FAQ", color: Colors.blue[100], iconColor: Colors.blue , index: 4,),
              MenuButton(icon: Icons.info_outlined, text: "About Us", color: Colors.grey[300], iconColor: Colors.black , index: 5,),
            ],
          ),
        ),
      ],
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;
  final Color iconColor;
   final int ? index  ;

  MenuButton({required this.icon, required this.text, required this.color, required this.iconColor , required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(20.0),
            left: Radius.circular(20.0),
          ),
          color: color,
        ),
        child: MaterialButton(
          onPressed: () {
            if (index ==4 ) {  Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => questions()),
            );;}
            else if (index == 5 ) {Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => about()),
            );}
            else if (index == 2 ){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => tracking()),
              );
            }
            else if (index == 1 ) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RecycleScreen  (donate: false,)),
              );
            }
          },
          child: Row(
            children: [
              Icon(icon, color: iconColor),
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
