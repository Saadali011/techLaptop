import 'package:flutter/material.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  final ValueChanged<String>? onSearchChanged;
  final FocusNode focusNode;

  const HomeHeader({Key? key, this.onSearchChanged, required this.focusNode}) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {
        _isSearchFocused = widget.focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _isSearchFocused
                  ? MediaQuery.of(context).size.width * 0.9
                  : MediaQuery.of(context).size.width * 0.5,
              child: SearchField(
                focusNode: widget.focusNode,
                onSearchChanged: widget.onSearchChanged ?? (String value) {},
              ),
            ),
          ),
          const SizedBox(width: 16),
          Visibility(
            visible: !_isSearchFocused,
            child: Row(
              children: [
                IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  press: () {},
                ),
                const SizedBox(width: 8),
                IconBtnWithCounter(
                  svgSrc: "assets/icons/Bell.svg",
                  numOfitem: 3,
                  press: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
