import 'package:flutter/material.dart';
import 'package:laptopharbor/Provider/cart_provider.dart';
import 'package:laptopharbor/Provider/chat_provider.dart';
import 'package:laptopharbor/presentation/chats/chat_screen.dart';
import 'package:provider/provider.dart'; // Make sure to import Provider
import 'package:laptopharbor/presentation/splash_screen/splash_screen.dart';
import 'package:laptopharbor/routes.dart';
import 'theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add your providers here, e.g.,
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Laptop Harbor',
        theme: AppTheme.lightTheme(context),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
