import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laptopharbor/presentation/home/components/search_field.dart';
import '../../../data/demo_data.dart';
import '../../Notifications/notification.dart';
import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';

class HomeHeader extends StatefulWidget {
  final ValueChanged<String>? onSearchChanged;
  final FocusNode focusNode;

  const HomeHeader({Key? key, this.onSearchChanged, required this.focusNode}) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final FocusNode _focusNode = FocusNode();
  bool _isSearchFocused = false;
  List<String> notifications = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isSearchFocused = _focusNode.hasFocus;
      });
    });
    _loadNotifications();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notifications = prefs.getStringList('notifications') ?? [];
    });
  }

  Future<void> _saveNotification(String notification) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> updatedNotifications = [...notifications, notification];
    prefs.setStringList('notifications', updatedNotifications);
    setState(() {
      notifications = updatedNotifications;
    });
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
                focusNode: _focusNode,
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
                    notifications: notifications,
                    press: () { Navigator.pushNamed(context, CartScreen.routeName); }
                ),
                const SizedBox(width: 8),
                IconBtnWithCounter(
                  svgSrc: "assets/icons/Bell.svg",
                  notifications: notifications,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
