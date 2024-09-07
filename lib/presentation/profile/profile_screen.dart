import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/demo_data.dart';
import '../../firebase_auth/firebase_auth_services.dart';
import '../Notifications/notification.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _profileImageUrl = "";
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  List<String> notifications = [];


  final FirebaseAuthService _authService = FirebaseAuthService(); // Instance of FirebaseAuthService

  Future<void> _handleSignOut() async {
    await _authService.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }
  // @override
  // void initState() {
  //   super.initState();
  //   _loadProfileImage();
  // }
  //
  // Future<void> _loadProfileImage() async {
  //   try {
  //     var doc = await _firestore.collection('users').doc('user_id').get();
  //     setState(() {
  //       _profileImageUrl = doc.data()?['profileImageUrl'] ?? "";
  //     });
  //   } catch (e) {
  //     print('Error loading profile image: $e');
  //   }
  // }
  //
  // Future<void> _uploadProfilePicture(XFile image) async {
  //   setState(() {
  //     _isUploading = true;
  //   });
  //
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   Reference ref = _storage.ref().child('profile_pictures/$fileName');
  //   File file = File(image.path);
  //
  //   try {
  //     await ref.putFile(file);
  //     String downloadUrl = await ref.getDownloadURL();
  //
  //     await _firestore.collection('users').doc('user_id').update({
  //       'profileImageUrl': downloadUrl,
  //     });
  //
  //     setState(() {
  //       _profileImageUrl = downloadUrl;
  //     });
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //   } finally {
  //     setState(() {
  //       _isUploading = false;
  //     });
  //   }
  // }
  //
  // Future<void> _removeProfilePicture() async {
  //   try {
  //     Reference ref = _storage.refFromURL(_profileImageUrl);
  //     await ref.delete();
  //
  //     await _firestore.collection('users').doc('user_id').update({
  //       'profileImageUrl': FieldValue.delete(),
  //     });
  //
  //     setState(() {
  //       _profileImageUrl = "";
  //     });
  //   } catch (e) {
  //     print('Error removing image: $e');
  //   }
  // }
  //
  // void _pickImage(ImageSource source) async {
  //   var status = await [
  //     Permission.camera,
  //     Permission.photos,
  //   ].request();
  //
  //   if (status[Permission.camera]?.isGranted == true || status[Permission.photos]?.isGranted == true) {
  //     try {
  //       final XFile? image = await _picker.pickImage(source: source);
  //       if (image != null) {
  //         Navigator.pop(context); // Close the BottomSheet
  //         _uploadProfilePicture(image);
  //       } else {
  //         print('No image selected.');
  //       }
  //     } catch (e) {
  //       print('Error picking image: $e');
  //     }
  //   } else {
  //     print('Camera or gallery permission denied.');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please allow camera and gallery permissions.')),
  //     );
  //   }
  // }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 45,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.cancel, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Profile photo",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  if (_profileImageUrl.isNotEmpty)
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Navigator.pop(context);
                        // _removeProfilePicture();
                      },
                    ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // _pickImage(ImageSource.camera);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Icon(Icons.camera_alt, color: Colors.blue, size: 30),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // _pickImage(ImageSource.gallery);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Icon(Icons.photo_library, color: Colors.blue, size: 30),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfilePic(
              imagePath: _profileImageUrl.isNotEmpty
                  ? _profileImageUrl
                  : "assets/images/picture.png",
              onChangePicture: () => _showBottomSheet(context),
              onRemovePicture: (){},
              // onRemovePicture: _removeProfilePicture,
            ),
            if (_isUploading) CircularProgressIndicator(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(
                      notifications: notifications,
                      products: [demoProducts[0]], // Example product data
                    ),
                  ),
                );

              },
            ),
            // ProfileMenu(
            //   text: "Change Password",
            //   icon: "assets/icons/lock.svg",
            //   press: () {},
            // ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () async  {
                await _handleSignOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
