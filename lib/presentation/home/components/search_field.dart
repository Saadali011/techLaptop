import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final FocusNode focusNode;
  final ValueChanged<String> onSearchChanged;

  const SearchField({
    Key? key,
    required this.focusNode,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onChanged: onSearchChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: searchOutlineInputBorder,
        focusedBorder: searchOutlineInputBorder,
        enabledBorder: searchOutlineInputBorder,
        hintText: "Search product",
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}

const searchOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);
