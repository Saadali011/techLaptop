import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptopharbor/presentation/init_screen.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../home/home_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  bool _obscureText = true;
  final List<String?> errors = [];
  FirebaseAuth _auth = FirebaseAuth.instance;

  final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  final RegExp passwordValidatorRegExp = RegExp(r".{8,}");

  Color emailBorderColor = Colors.grey;
  Color emailIconColor = Colors.grey;
  Color emailLabelColor = Colors.grey;
  Color passwordBorderColor = Colors.grey;
  Color passwordIconColor = Colors.grey;
  Color passwordLabelColor = Colors.grey;

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

  void updateValidation() {
    setState(() {
      if (email == null || email!.isEmpty || !emailValidatorRegExp.hasMatch(email!)) {
        addError(error: kInvalidEmailError);
        passwordBorderColor = Colors.grey;
        passwordIconColor = Colors.grey;
        passwordLabelColor = Colors.grey;
      } else {
        removeError(error: kInvalidEmailError);
        passwordBorderColor = Colors.grey;
        passwordIconColor = Colors.grey;
        passwordLabelColor = Colors.grey;

        if (password != null && password!.isNotEmpty) {
          if (!passwordValidatorRegExp.hasMatch(password!)) {
            addError(error: kShortPassError);
          } else {
            removeError(error: kShortPassError);
          }
        }
      }
    });
  }

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showLoadingDialog();
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email!,
          password: password!,
        );
        if (userCredential.user != null && userCredential.user!.emailVerified) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            InitScreen.routeName,
                (Route<dynamic> route) => false,
          );
        } else {
          hideLoadingDialog();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please verify your email before signing in.")),
          );
        }
      } catch (e) {
        hideLoadingDialog();
        String errorMessage = "An unknown error occurred. Please try again.";
        if (e.toString().contains('user-not-found')) {
          errorMessage = "No user found with this email.";
        } else if (e.toString().contains('wrong-password')) {
          errorMessage = "Incorrect password. Please try again.";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        );
      },
    );
  }

  void hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              updateValidation();
            },
            validator: (value) {
              if (value == null || value.isEmpty || !emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: emailBorderColor),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: emailBorderColor),
                gapPadding: 10,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: _obscureText,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              updateValidation();
            },
            validator: (value) {
              if (value == null || value.isEmpty || !passwordValidatorRegExp.hasMatch(value)) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: passwordBorderColor),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: passwordBorderColor),
                gapPadding: 10,
              ),
            ),
          ),
          const SizedBox(height: 20),
          FormError(errors: errors),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: signIn,
            child: const Text("Sign In"),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
            },
            child: Text(
              "Forgot Password?",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
