import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:usb32/signin_screen.dart';


class AuthClasss {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
        });
        await _firestore.collection('energie').doc(user.uid).set({
          'name': name,
          'current': 'NA A',
          'voltage': 'NA V',
          'power': 'NA W',
          'energy': 'NA Wh',
        });
        return "Created";
      }
      return "Error";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
   GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String uppercasetPattern = '^(.*?[A-Z]){1,}';
  String numericPattern = '^(.*?[0-9]){1,}';
  String specialPattern = r"^(.*?[$&+,\:;/=?@#|'<>.^*()_%!-]){1,}";
  bool _tickValue = true;
  bool isValidPassword = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      margin: const EdgeInsets.only(top: 80),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3.0,
                            color: Color.fromRGBO(5, 25, 55, 1),
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: const Text(
                          'SIGN - UP',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 100),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: width * 0.12),
                    Form(
                      key: _formKey1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          buildTextField(
                            context: context,
                            controller: _nameController,
                            hintText: 'Full Name',
                            icon: Icons.person_outline,
                          ),
                          SizedBox(height: width * 0.04),
                          buildTextField(
                            context: context,
                            controller: _emailController,
                            hintText: 'Email Id',
                            icon: Icons.email_outlined,
                          ),
                          SizedBox(height: width * 0.04),
                          buildTextField(
                            context: context,
                            controller: _passwordController,
                            hintText: 'Password',
                            icon: Icons.lock,
                            obscureText: true,
                            onChanged: (txt) {
                              validatePassword();
                            },
                          ),
                          if (_passwordController.text.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                isValidPassword ? "Strong password" : "Weak password",
                              ),
                            ),
                          SizedBox(height: width * 0.04),
                          buildTextField(
                            context: context,
                            controller: _cPasswordController,
                            hintText: 'Confirm Password',
                            icon: Icons.lock_open_outlined,
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: width * 0.08),
                    SizedBox(
                      height: width * 0.12,
                      width: width,
                      child: ElevatedButton(
                        onPressed: () {
                          signUp();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: _tickValue
                              ? const Color.fromRGBO(5, 25, 55, 1)
                              : const Color.fromRGBO(5, 25, 55, 0.5),
                          minimumSize: Size(width, height * 0.06),
                          maximumSize: Size(width, height * 0.06),
                        ),
                        child: const Text(
                          'SIGN-UP',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignInScreen()));
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already a member? ',
                          style: const TextStyle(color: Colors.black),
                          children: const [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validatePassword() {
    bool hasMinLength, hasMinUppercaseChar, hasMinNumericChar, hasMinSpecialChar;
    hasMinLength = _passwordController.text.trim().length >= 6;
    hasMinUppercaseChar = _passwordController.text.contains(RegExp(uppercasetPattern));
    hasMinNumericChar = _passwordController.text.contains(RegExp(numericPattern));
    hasMinSpecialChar = _passwordController.text.contains(RegExp(specialPattern));

    setState(() {
      isValidPassword = hasMinLength && hasMinUppercaseChar && hasMinNumericChar && hasMinSpecialChar;
    });
  }

  void signUp() async {
    if (_tickValue) {
      if (_emailController.text.isEmpty || _nameController.text.isEmpty || _passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fill all the fields.")));
      } else if (!isValidPassword) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter valid password.")));
      } else if (_passwordController.text != _cPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password & confirm password does not match.")));
      } else {
        setState(() {
          isLoading = true;
        });
        AuthClasss()
            .createUser(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _nameController.text.trim(),
        )
            .then((value) {
          if (value == "Created") {
            setState(() {
              isLoading = false;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
                (route) => false,
              );
            });
          } else {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
          }
        });
      }
    }
  }

  Widget buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Function(String)? onChanged,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: width * 0.15,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.01,
            color: Color.fromRGBO(0, 0, 0, 0.12),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shadowColor: Colors.black38,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            prefixIcon: Container(
              height: height,
              margin: EdgeInsets.only(right: width * 0.01),
              width: width * 0.1,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(5, 25, 55, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  )),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            hintText: '  $hintText',
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.transparent),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
