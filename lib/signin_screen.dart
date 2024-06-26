
import 'package:flutter/material.dart';
import 'package:usb32/auth_provider.dart';
import 'package:usb32/forgetpassword_screen.dart';
import 'package:usb32/homepage.dart';
import 'package:usb32/signup_screen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String _email = "";
  final String _password = "";
  bool isLoading = false;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                      margin: const EdgeInsets.only(
                        top: 80,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 3.0, color: Color.fromRGBO(5, 25, 55, 1)),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Text('LOGIN',

                      ),
                    )
                     )     ],
                ),
              ),
              Container(
                // height: height,
                margin: EdgeInsets.only(top: 100),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: width * 0.12),
                    Form(
                      key: _formKey,
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
                                      Icons.phone_android,
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
                    SizedBox(height: width * 0.04),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ForgetPassword()));
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Forgot password?',
                        
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                     
                    SizedBox(height: width * 0.08),
                    SizedBox(
                      height: width * 0.12,
                      width: width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(5, 25, 55, 1),
                          minimumSize: Size(width, height * 0.06),
                          maximumSize: Size(width, height * 0.06),
                          // foreground
                        ),
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => HomeScreen()));

                          setState(() {
                            isLoading = true;
                          });

                          AuthClass()
                              .signIN(_emailController.text.trim(),
                                  _passwordController.text.trim())
                              .then((value) {
                            if (value == "Welcome" &&
                                _emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                  (route) => false);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(value)));
                            }
                          });
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: width * 0.05),
                     GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Not a Member ? ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: ' Sign up',
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
