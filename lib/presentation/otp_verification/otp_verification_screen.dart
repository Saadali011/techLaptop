import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../components/form_error.dart';
import '../home/home_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  static String routeName = "/otp_verification";

  const OTPVerificationScreen({super.key});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController _otpController;
  String? vCode;
  bool _loading = false;
  final List<String?> errors = [];

  // Initialize the controller
  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  // Dispose the controller
  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Future<void> verifyEmail() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _loading = true;
      });

      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final email = arguments['email'] as String;

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null && user.email == email) {
          await user.reload();
          if (user.emailVerified) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
                  (Route<dynamic> route) => false,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please verify your email before signing in.")),
            );
          }
        }
      } catch (e) {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong: $e")),
        );
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    inactiveFillColor: const Color(0xFFFFFFFF), // Replace with your desired color
                    selectedFillColor: const Color(0xFFFFFFFF),
                    inactiveColor: const Color(0xFFEEEEEE),
                    shape: PinCodeFieldShape.box,
                    selectedColor: Colors.green,
                    fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 0.5),
                    borderRadius: BorderRadius.circular(7),
                    fieldHeight: 96,
                    borderWidth: 1,
                    fieldWidth: MediaQuery.of(context).size.width * 0.14,
                    activeFillColor: const Color(0xFFFFFFFF),
                  ),
                  hintCharacter: "—",
                  hintStyle: const TextStyle(color: Color(0xffC4F3D4)),
                  cursorColor: Colors.green,
                  animationDuration: const Duration(milliseconds: 300),
                  keyboardType: TextInputType.number,
                  onChanged: (String code) {
                    setState(() {
                      vCode = code;
                    });
                  },
                  controller: _otpController,
                  onCompleted: (String code) {
                    vCode = code;
                  },
                  beforeTextPaste: (String? text) {
                    return true;
                  },
                  pastedTextStyle: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                ),
                const SizedBox(height: 20),
                FormError(errors: errors),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loading ? null : verifyEmail,
                  child: _loading
                      ? const CircularProgressIndicator()
                      : const Text("Verify Email"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
