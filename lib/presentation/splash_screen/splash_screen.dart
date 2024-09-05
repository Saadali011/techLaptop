import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/constants.dart';
import '../init_screen.dart';
import '../sign_in/sign_in_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _loadingProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    debugPrint("Initializing Splash Screen...");

    await Future.delayed(const Duration(milliseconds: 500));

    await _fetchDataFromFirebase();
    await _simulateLoading();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      debugPrint("User is signed in, navigating to Init Screen...");
      Navigator.of(context).pushNamedAndRemoveUntil(
        InitScreen.routeName,
            (Route<dynamic> route) => false, // Remove all previous routes
      );
    } else {
      debugPrint("User is not signed in, navigating to Sign In Screen...");
      Navigator.of(context).pushNamedAndRemoveUntil(
        SignInScreen.routeName,
            (Route<dynamic> route) => false, // Remove all previous routes
      );
    }
  }


  Future<void> _fetchDataFromFirebase() async {
    try {
      // Example: Fetch some data from Firestore
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore.collection('your_collection').get();

      // Process your data if needed
      debugPrint("Data fetched: ${snapshot.docs.length} documents.");
    } catch (e) {
      debugPrint("Failed to fetch data: $e");
    }
  }

  Future<void> _simulateLoading() async {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        _loadingProgress = i * 0.1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.transparent,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/logo/logo.png",
                  width: MediaQuery.of(context).size.width * 0.7, // 70% of screen width
                ),
              ],
            ),
            Column(
              children: <Widget>[
                const Text(
                  "Please wait, loading...",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 14.0,
                          color: Colors.grey[800],
                        ),
                        FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _loadingProgress,
                          child: Container(
                            height: 14.0,
                            color:  Color(green_color),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
