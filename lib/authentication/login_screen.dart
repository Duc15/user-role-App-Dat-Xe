import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:users_app/authentication/signup_screen.dart';
import 'package:users_app/global/global_var.dart';

import '../methods/common_methods.dart';
import '../pages/home_page.dart';
import '../widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final CommonMethods cMethods = CommonMethods();

  String? emailError, passwordError;

  void validateForm() {
    setState(() {
      emailError = null;
      passwordError = null;
    });

    if (!emailTextEditingController.text.contains("@")) {
      emailError = "Vui lòng nhập đúng định dạng email.";
    }
    if (passwordTextEditingController.text.trim().length < 6) {
      passwordError = "Mật khẩu phải lớn hơn hoặc bằng 6 ký tự.";
    }

    if ([emailError, passwordError].every((e) => e == null)) {
      signInUser();
    }
  }

  Future<void> signInUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Đang đăng nhập..."),
    );

    try {
      final User? userFirebase =
          (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      ))
              .user;

      if (!context.mounted) return;
      Navigator.pop(context);

      if (userFirebase != null) {
        DatabaseReference usersRef = FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(userFirebase.uid);
        final snap = await usersRef.once();

        if (snap.snapshot.value != null) {
          if ((snap.snapshot.value as Map)["blockStatus"] == "no") {
            userName = (snap.snapshot.value as Map)["name"];
            userPhone = (snap.snapshot.value as Map)["phone"];
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (c) => const HomePage()),
            );
          } else {
            FirebaseAuth.instance.signOut();
            cMethods.displaySnackBar(
                "Tài khoản bị khóa. Liên hệ: pm02duc@gmail.com.", context);
          }
        } else {
          FirebaseAuth.instance.signOut();
          cMethods.displaySnackBar("Hồ sơ của bạn không tồn tại.", context);
        }
      }
    } catch (error) {
      Navigator.pop(context);
      cMethods.displaySnackBar(error.toString(), context);
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? errorText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          errorText: errorText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset(
                "assets/images/logo.png",
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                "Đăng nhập",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                label: "Email",
                controller: emailTextEditingController,
                errorText: emailError,
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              _buildTextField(
                label: "Mật khẩu",
                controller: passwordTextEditingController,
                errorText: passwordError,
                obscureText: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: validateForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Đăng nhập",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (c) => const SignUpScreen()),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: "Bạn chưa có tài khoản? ",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "Đăng ký ngay!",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
