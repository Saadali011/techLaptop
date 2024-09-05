import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laptopharbor/components/add_data.dart';
import 'package:laptopharbor/components/utils.dart';

import '../../../constants.dart';

class ProfilePic extends StatefulWidget {
  final String imagePath;
  final VoidCallback onChangePicture;
  final VoidCallback onRemovePicture;

  const ProfilePic({
    Key? key,
    required this.imagePath,
    required this.onChangePicture,
    required this.onRemovePicture,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {

  Uint8List? _image;

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
  void SaveProfile() async {
    String resp = await StoreData().saveData(file: _image!);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _image != null ?
        CircleAvatar(
          radius: 64,
          backgroundImage: MemoryImage(
              _image!
          ),
        ) :
        const CircleAvatar(
          radius: 64,
          backgroundImage: NetworkImage("https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo.png"),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SizedBox(
            height: 46,
            width: 46,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(color: kPrimaryColor),
                ),
                backgroundColor: const Color(0xFFF5F6F9),
              ),
              onPressed: selectImage,
              child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
            ),
          ),
        ),
        // CircleAvatar(
        //   radius: 64,
        //   backgroundColor: Colors.grey.shade200,
        //   backgroundImage: imagePath.isNotEmpty
        //       ? NetworkImage(imagePath)
        //       : AssetImage("assets/images/picture.png") as ImageProvider,
        //   child: imagePath.isEmpty
        //       ? Icon(Icons.person, size: 64, color: Colors.grey)
        //       : null,
        // ),
        // Positioned(
        //   bottom: 0,
        //   right: 0,
        //   child: SizedBox(
        //     height: 46,
        //     width: 46,
        //     child: TextButton(
        //       style: TextButton.styleFrom(
        //         foregroundColor: kPrimaryColor,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(50),
        //           side: const BorderSide(color: kPrimaryColor),
        //         ),
        //         backgroundColor: const Color(0xFFF5F6F9),
        //       ),
        //       onPressed: onChangePicture,
        //       child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
