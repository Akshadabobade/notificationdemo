import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_notification/home_page.dart';
import 'package:local_notification/services/auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.0),
              Text(
                _isLogin ? "Welcome Back!" : "Create Account",
                style: GoogleFonts.aclonica(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _isLogin ? "Sign in to continue" : "Sign up to get started ",
                style: GoogleFonts.aclonica(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 40.0),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email ID";
                        }

                        if (!value.contains("@") || !value.contains(".")) {
                          return "Please enter a valid email ID";
                        }

                        return null; // Validation passed
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        suffixIcon: Icon(Icons.visibility),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }

                        if (value.length < 8) {
                          return "Password must be at least 8 characters long";
                        }

                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return "Password must have at least one uppercase letter";
                        }

                        if (!value.contains(RegExp(r'[0-9]'))) {
                          return "Password must have at least one number";
                        }

                        if (!value.contains(RegExp(r'[@$!%*?&]'))) {
                          return "Password must have at least one special character (@, \$, !, %, *, ?, &)";
                        }
                        return null; // Validation passed
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              if (_isLogin)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // throw Exception();
                    },
                    child: Text(
                      "Forgot Password",
                      style: GoogleFonts.aclonica(color: Colors.blue),
                    ),
                  ),
                ),
              SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                height: 55.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () async {
                    if (_isLogin) {
                      //CALL LOGIN FIREBASE API
                    } else {
                      //CALL SIGNUP FIREBASE API
                      try {
                        UserCredential user = await _authService
                            .registerWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        print(user.user?.email);

                        if (user.user?.email != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      } catch (ex) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(ex.toString())));
                      }
                    }
                  },
                  child: Text(
                    _isLogin ? "Sign in" : "Sign up",
                    style: GoogleFonts.aclonica(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isLogin
                        ? "Don't have an account?"
                        : "Already have an account?",
                    style: GoogleFonts.aclonica(color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin ? "Sign Up" : "Sign in",
                      style: GoogleFonts.aclonica(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}