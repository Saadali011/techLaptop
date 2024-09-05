import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback? press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
            color: Colors.black,
          ),
        ),
        if (press != null) // Only show "See all" if press is not null
          TextButton(
            onPressed: press,
            style: TextButton.styleFrom(foregroundColor: Colors.grey),
            child: const Text("See all"),
          ),
      ],
    );
  }
}
