import 'package:flutter/widgets.dart';
import 'package:laptopharbor/presentation/details/details_screen.dart';
import 'package:laptopharbor/presentation/home/components/product_brand.dart';
import 'package:laptopharbor/presentation/home/home_screen.dart';
import 'package:laptopharbor/presentation/init_screen.dart';
import 'package:laptopharbor/presentation/otp_verification/otp_verification_screen.dart';
import 'package:laptopharbor/presentation/products/products_screen.dart';
import 'package:laptopharbor/presentation/sign_in/sign_in_screen.dart';
import 'package:laptopharbor/presentation/sign_up/sign_up_screen.dart';
import 'package:laptopharbor/presentation/splash_screen/splash_screen.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  OTPVerificationScreen.routeName: (context) => const OTPVerificationScreen(),
  InitScreen.routeName: (context) => const InitScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  ProductsScreen.routeName: (context) => const ProductsScreen(),
  // ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  // LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  // CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  // OtpScreen.routeName: (context) => const OtpScreen(),
  // CartScreen.routeName: (context) => const CartScreen(),
  // ProfileScreen.routeName: (context) => const ProfileScreen(),
};
