import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/methods/common_methods.dart';
import 'package:users_app/pages/home_page.dart';
import 'package:users_app/widgets/loading_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userNameTextEditingController =
      TextEditingController();
  final TextEditingController userPhoneTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final CommonMethods cMethods = CommonMethods();

  String? nameError, phoneError, emailError, passwordError;

  void validateForm() {
    setState(() {
      nameError = null;
      phoneError = null;
      emailError = null;
      passwordError = null;
    });

    if (userNameTextEditingController.text.trim().length < 4) {
      nameError = "Tên của bạn phải có ít nhất 4 ký tự.";
    }
    if (userPhoneTextEditingController.text.trim().length < 10) {
      phoneError = "Số điện thoại phải có 10 số.";
    }
    if (!emailTextEditingController.text.contains("@")) {
      emailError = "Hãy nhập email hợp lệ.";
    }
    if (passwordTextEditingController.text.trim().length < 6) {
      passwordError = "Mật khẩu phải có ít nhất 6 ký tự.";
    }

    if ([nameError, phoneError, emailError, passwordError]
        .every((e) => e == null)) {
      registerNewUser();
    }
  }

  Future<void> registerNewUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Đang tạo tài khoản..."),
    );

    try {
      final User? userFirebase =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      ))
              .user;

      if (userFirebase == null) return;
      Navigator.pop(context);

      DatabaseReference usersRef = FirebaseDatabase.instance
          .ref()
          .child("users")
          .child(userFirebase.uid);

      Map userDataMap = {
        "name": userNameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": userPhoneTextEditingController.text.trim(),
        "id": userFirebase.uid,
        "blockStatus": "no",
      };

      usersRef.set(userDataMap);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => const HomePage()),
      );
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
                "Đăng ký tài khoản",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                label: "Tên người dùng",
                controller: userNameTextEditingController,
                errorText: nameError,
                icon: Icons.person,
              ),
              _buildTextField(
                label: "Số điện thoại",
                controller: userPhoneTextEditingController,
                errorText: phoneError,
                keyboardType: TextInputType.phone,
                icon: Icons.phone,
              ),
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
                  "Đăng ký",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (c) => const LoginScreen()),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: "Bạn đã có tài khoản? ",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "Đăng nhập ngay!",
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
