import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:usb32/auth_provider.dart';
import 'package:usb32/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
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
                        margin: const EdgeInsets.only(
                          top: 80,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 3.0,
                                color: Color.fromRGBO(5, 25, 55, 1)),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: Text(
                            'SIGN - UP',
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                // height: height,
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
                          Container(
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
                                controller: _nameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  prefixIcon: Container(
                                    height: height,
                                    margin:
                                        EdgeInsets.only(right: width * 0.01),
                                    width: width * 0.1,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(5, 25, 55, 1),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5))),
                                    child: const Icon(
                                      Icons.person_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: '  Full Name',

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  // focusColor: purple,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: width * 0.04),
                          Container(
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
                                controller: _emailController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  prefixIcon: Container(
                                    height: height,
                                    margin:
                                        EdgeInsets.only(right: width * 0.01),
                                    width: width * 0.1,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(5, 25, 55, 1),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5))),
                                    child: const Icon(
                                      Icons.email_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: '  Email Id',

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  // focusColor: purple,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: width * 0.04),
                          Container(
                            height: width * 0.15,
                            child: Card(
                              elevation: 0,
                              shadowColor: Colors.white,
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                onChanged: (txt) {
                                  bool hasMinLength,
                                      hasMinUppercaseChar,
                                      hasMinNumericChar,
                                      hasMinSpecialChar;
                                  hasMinLength =
                                      _passwordController.text.trim().length >=
                                          6;
                                  hasMinUppercaseChar = _passwordController.text
                                      .contains(RegExp(uppercasetPattern));
                                  hasMinNumericChar = _passwordController.text
                                      .contains(RegExp(numericPattern));
                                  hasMinSpecialChar = _passwordController.text
                                      .contains(RegExp(specialPattern));

                                  setState(() {
                                    isValidPassword = hasMinLength &&
                                        hasMinUppercaseChar &&
                                        hasMinNumericChar &&
                                        hasMinSpecialChar;
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  prefixIcon: Container(
                                    height: height,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(5, 25, 55, 1),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5))),
                                    margin:
                                        EdgeInsets.only(right: width * 0.01),
                                    width: width * 0.1,
                                    child: const Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                  ),

                                  hintText: '  Password',

                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 0, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  // focusColor: purple,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 0, color: Colors.white),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  spreadRadius: 0.01,
                                  color: Color.fromRGBO(0, 0, 0, 0.12),
                                  blurRadius: 12.0)
                            ]),
                          ),
                          if (_passwordController.text.length > 0)
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: isValidPassword
                                  ? Text(
                                      "Strong password",
                                    )
                                  : Text(
                                      "Weak password",
                                    ),
                            ),
                          SizedBox(height: width * 0.04),
                          Container(
                            height: width * 0.15,
                            child: Card(
                              elevation: 0,
                              shadowColor: Colors.white,
                              child: TextFormField(
                                controller: _cPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  prefixIcon: Container(
                                    height: height,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(5, 25, 55, 1),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5))),
                                    margin:
                                        EdgeInsets.only(right: width * 0.01),
                                    width: width * 0.1,
                                    child: const Icon(
                                      Icons.lock_open_outlined,
                                      color: Colors.white,
                                    ),
                                  ),

                                  hintText: '  Confirm Password',

                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 0, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  // focusColor: purple,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 0, color: Colors.white),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 0.01,
                                  color: Color.fromRGBO(0, 0, 0, 0.12),
                                  blurRadius: 12.0,
                                ),
                              ],
                            ),
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
                          if (_tickValue) {
                            if (_emailController.text.isEmpty ||
                                _nameController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Fill all the fields.")));
                            } else if (!isValidPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Enter valid password.")));
                            } else if (_passwordController.text !=
                                _cPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Password & confirm password dose not match.")));
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              AuthClass()
                                  .createUser(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                      _nameController.text.trim())
                                  .then((value) {
                                if (value == "Created") {
                                  setState(() {
                                    isLoading = false;
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignInScreen()),
                                        (route) => false);
                                  });
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(value)));
                                }
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: _tickValue
                              ? Color.fromRGBO(5, 25, 55, 1)
                              : Color.fromRGBO(5, 25, 55, 0.5),
                          minimumSize: Size(width, height * 0.06),
                          maximumSize: Size(width, height * 0.06),
                          // foreground
                        ),
                        child: const Text(
                          'SIGN-UP',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'a Member ? ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: ' login',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
